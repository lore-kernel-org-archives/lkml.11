Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB25C32792
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 12:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359229AbiHWMFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359508AbiHWMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:01:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A259D9EB3;
        Tue, 23 Aug 2022 02:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDC4AB81C89;
        Tue, 23 Aug 2022 09:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F621C433C1;
        Tue, 23 Aug 2022 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247361;
        bh=t5e8m7zUSZLlKDZ0aO+vYJnddTUtFWDaqH96W3GXM0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+W40H6L8IJJS/fsuZ5KyUSl6wL7u1eSeurYunTmOp2ZaxA1As3NDo/l6DE6AFNxx
         +THEsCrHMPQBlBgcgsp7c/yL2olG4ETAg1Bbnxzx8CvV3MXSoJ6O9T51lK0hTs17Dv
         vlptXb1WLrS9oqwHWRpbMn6pesn5K96iIQ1dObOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        Sebastian Haas <haas@ems-wuensche.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10 012/158] can: ems_usb: fix clangs -Wunaligned-access warning
Date:   Tue, 23 Aug 2022 10:25:44 +0200
Message-Id: <20220823080046.564352370@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080046.056825146@linuxfoundation.org>
References: <20220823080046.056825146@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit a4cb6e62ea4d36e53fb3c0f18ea4503d7b76674f upstream.

clang emits a -Wunaligned-access warning on struct __packed
ems_cpc_msg.

The reason is that the anonymous union msg (not declared as packed) is
being packed right after some non naturally aligned variables (3*8
bits + 2*32) inside a packed struct:

| struct __packed ems_cpc_msg {
| 	u8 type;	/* type of message */
| 	u8 length;	/* length of data within union 'msg' */
| 	u8 msgid;	/* confirmation handle */
| 	__le32 ts_sec;	/* timestamp in seconds */
| 	__le32 ts_nsec;	/* timestamp in nano seconds */
|	/* ^ not naturally aligned */
|
| 	union {
| 	/* ^ not declared as packed */
| 		u8 generic[64];
| 		struct cpc_can_msg can_msg;
| 		struct cpc_can_params can_params;
| 		struct cpc_confirm confirmation;
| 		struct cpc_overrun overrun;
| 		struct cpc_can_error error;
| 		struct cpc_can_err_counter err_counter;
| 		u8 can_state;
| 	} msg;
| };

Starting from LLVM 14, having an unpacked struct nested in a packed
struct triggers a warning. c.f. [1].

Fix the warning by marking the anonymous union as packed.

[1] https://github.com/llvm/llvm-project/issues/55520

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Link: https://lore.kernel.org/all/20220802094021.959858-1-mkl@pengutronix.de
Cc: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Cc: Sebastian Haas <haas@ems-wuensche.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/ems_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -194,7 +194,7 @@ struct __packed ems_cpc_msg {
 	__le32 ts_sec;	/* timestamp in seconds */
 	__le32 ts_nsec;	/* timestamp in nano seconds */
 
-	union {
+	union __packed {
 		u8 generic[64];
 		struct cpc_can_msg can_msg;
 		struct cpc_can_params can_params;


