Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D64C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 15:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376465AbiCYP1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376665AbiCYPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:23:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C49DE4399;
        Fri, 25 Mar 2022 08:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B88E0CE2A46;
        Fri, 25 Mar 2022 15:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E24C340E9;
        Fri, 25 Mar 2022 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648221366;
        bh=bLyHvRHuwpHkVvuattikF0PH4TZTbUXMmVmmup3vp7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gN+1at4U7s/QbEyP3y3Tu/+BGdBz9uErtDez56QC+/P5MoXknMu4LB8xP7Rwvu5TY
         jhvrnSAl07ZB1jZ1pIAp8TcDznIq9D5kpckbanBH0S38GPV4DRNZIm2WZpXEIigal3
         TzNKfpMtXcCoW2LCpodNbczfWAXoSmd9nE8BTSrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 5.15 34/37] tpm: use try_get_ops() in tpm-space.c
Date:   Fri, 25 Mar 2022 16:14:35 +0100
Message-Id: <20220325150420.906684399@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325150419.931802116@linuxfoundation.org>
References: <20220325150419.931802116@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>

commit fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9 upstream.

As part of the series conversion to remove nested TPM operations:

https://lore.kernel.org/all/20190205224723.19671-1-jarkko.sakkinen@linux.intel.com/

exposure of the chip->tpm_mutex was removed from much of the upper
level code.  In this conversion, tpm2_del_space() was missed.  This
didn't matter much because it's usually called closely after a
converted operation, so there's only a very tiny race window where the
chip can be removed before the space flushing is done which causes a
NULL deref on the mutex.  However, there are reports of this window
being hit in practice, so fix this by converting tpm2_del_space() to
use tpm_try_get_ops(), which performs all the teardown checks before
acquring the mutex.

Cc: stable@vger.kernel.org # 5.4.x
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm2-space.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -58,12 +58,12 @@ int tpm2_init_space(struct tpm_space *sp
 
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
-	mutex_lock(&chip->tpm_mutex);
-	if (!tpm_chip_start(chip)) {
+
+	if (tpm_try_get_ops(chip) == 0) {
 		tpm2_flush_sessions(chip, space);
-		tpm_chip_stop(chip);
+		tpm_put_ops(chip);
 	}
-	mutex_unlock(&chip->tpm_mutex);
+
 	kfree(space->context_buf);
 	kfree(space->session_buf);
 }


