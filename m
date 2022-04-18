Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C67C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 14:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245678AbiDROHH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbiDRNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:50:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4728043ED9;
        Mon, 18 Apr 2022 06:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 992D160B3C;
        Mon, 18 Apr 2022 13:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB1EC385A1;
        Mon, 18 Apr 2022 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650286914;
        bh=qt6zVlScKlgp/UWRwAPjnLop5XpVwyg8xY7P3/aVvDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMDhF77/khFo99jstRfZI/L93PJkyoDeuzvTVTKU+P67MKsByE9vF2loQ5CQqWanC
         la2O0dk+lmv4b15F5S1Tll9l0uAac23WIPA2k99RaG3q0t6nkGl+WRtqaQ6TF8Cv2H
         sg6aHyg4dwTOti2+qL2jXcVUDZZzQVDPQNJ/o9/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Sven Peter <sven@svenpeter.dev>, Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 4.14 284/284] i2c: pasemi: Wait for write xfers to finish
Date:   Mon, 18 Apr 2022 14:14:25 +0200
Message-Id: <20220418121221.361218307@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121210.689577360@linuxfoundation.org>
References: <20220418121210.689577360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Povišer <povik+lin@cutebit.org>

commit bd8963e602c77adc76dbbbfc3417c3cf14fed76b upstream.

Wait for completion of write transfers before returning from the driver.
At first sight it may seem advantageous to leave write transfers queued
for the controller to carry out on its own time, but there's a couple of
issues with it:

 * Driver doesn't check for FIFO space.

 * The queued writes can complete while the driver is in its I2C read
   transfer path which means it will get confused by the raising of
   XEN (the 'transaction ended' signal). This can cause a spurious
   ENODATA error due to premature reading of the MRXFIFO register.

Adding the wait fixes some unreliability issues with the driver. There's
some efficiency cost to it (especially with pasemi_smb_waitready doing
its polling), but that will be alleviated once the driver receives
interrupt support.

Fixes: beb58aa39e6e ("i2c: PA Semi SMBus driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-pasemi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -145,6 +145,12 @@ static int pasemi_i2c_xfer_msg(struct i2
 
 		TXFIFO_WR(smbus, msg->buf[msg->len-1] |
 			  (stop ? MTXFIFO_STOP : 0));
+
+		if (stop) {
+			err = pasemi_smb_waitready(smbus);
+			if (err)
+				goto reset_out;
+		}
 	}
 
 	return 0;


