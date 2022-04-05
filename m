Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58416C4167E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbiDELAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiDEIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:38:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212F1D302;
        Tue,  5 Apr 2022 01:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E85460FFC;
        Tue,  5 Apr 2022 08:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B574EC385A1;
        Tue,  5 Apr 2022 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147570;
        bh=z03uRE2H7zmi68R1Q0lvr3LCmd3ruYnHuWykD/0EvBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUmMJfftu2Rlj/XZGnPxG5bKRLie6E+zE8pWxwZveZ1vZPXs8DQrn6CLga/r3poq2
         rxuJi1ooDFexSmGmQqknCvRk7Zh19BW67rhoufghGJa4wSMkYPuzJpslfW8Zi+V2P1
         gy+H9ubON2XL1zBE1t5RbTXnPiQylWNHgvNah5co=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 5.16 0044/1017] coresight: Fix TRCCONFIGR.QE sysfs interface
Date:   Tue,  5 Apr 2022 09:15:57 +0200
Message-Id: <20220405070355.490649888@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Clark <james.clark@arm.com>

commit ea75a342aed5ed72c87f38fbe0df2f5df7eae374 upstream.

It's impossible to program a valid value for TRCCONFIGR.QE
when TRCIDR0.QSUPP==0b10. In that case the following is true:

  Q element support is implemented, and only supports Q elements without
  instruction counts. TRCCONFIGR.QE can only take the values 0b00 or 0b11.

Currently the low bit of QSUPP is checked to see if the low bit of QE can
be written to, but as you can see when QSUPP==0b10 the low bit is cleared
making it impossible to ever write the only valid value of 0b11 to QE.
0b10 would be written instead, which is a reserved QE value even for all
values of QSUPP.

The fix is to allow writing the low bit of QE for any non zero value of
QSUPP.

This change also ensures that the low bit is always set, even when the
user attempts to only set the high bit.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Fixes: d8c66962084f ("coresight-etm4x: Controls pertaining to the reset, mode, pe and events")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20220120113047.2839622-2-james.clark@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -367,8 +367,12 @@ static ssize_t mode_store(struct device
 	mode = ETM_MODE_QELEM(config->mode);
 	/* start by clearing QE bits */
 	config->cfg &= ~(BIT(13) | BIT(14));
-	/* if supported, Q elements with instruction counts are enabled */
-	if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
+	/*
+	 * if supported, Q elements with instruction counts are enabled.
+	 * Always set the low bit for any requested mode. Valid combos are
+	 * 0b00, 0b01 and 0b11.
+	 */
+	if (mode && drvdata->q_support)
 		config->cfg |= BIT(13);
 	/*
 	 * if supported, Q elements with and without instruction


