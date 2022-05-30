Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 15:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiE3Pkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbiE3PkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:40:16 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 07:47:35 PDT
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8657E207EF6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:47:35 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202205301446317fba133b70edf42456
        for <linux-kernel@vger.kernel.org>;
        Mon, 30 May 2022 16:46:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vjCZnJlkGKf+jcIPuDFQBSVbJFVWz+DiqFe3ZaJS4b8=;
 b=QIzTsSQikYXPx9W4y2QpkNI1ifNbZAW1JTYmGOvMjwtwIB2IJkgReiuL3XwEE9sJs7ntah
 gbedjXj1ln7lheE9T3uG3BNpXwQTmHMT7FJAfpUzedelRT6ZUvWiLYPrc1jU5BC506xA3tvX
 NWOvk1lqtSEOoG4WcLybXeLBtY7/Q=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 8/9] tty: n_gsm: fix resource allocation order in gsm_activate_mux()
Date:   Mon, 30 May 2022 16:45:11 +0200
Message-Id: <20220530144512.2731-8-daniel.starke@siemens.com>
In-Reply-To: <20220530144512.2731-1-daniel.starke@siemens.com>
References: <20220530144512.2731-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Within gsm_activate_mux() all timers and locks are initiated before the
actual resource for the control channel is allocated. This can lead to race
conditions.

Allocate the control channel DLCI object first to avoid race conditions.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

There have been no comments on v2, hence, no change was done.

Link: https://lore.kernel.org/all/20220519070757.2096-8-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9e4ada510c9f..b0b093e8e9d9 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2483,6 +2483,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	struct gsm_dlci *dlci;
 	int ret;
 
+	dlci = gsm_dlci_alloc(gsm, 0);
+	if (dlci == NULL)
+		return -ENOMEM;
+
 	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 	INIT_WORK(&gsm->tx_work, gsmld_write_task);
@@ -2499,9 +2503,6 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	if (ret)
 		return ret;
 
-	dlci = gsm_dlci_alloc(gsm, 0);
-	if (dlci == NULL)
-		return -ENOMEM;
 	gsm->has_devices = true;
 	gsm->dead = false;		/* Tty opens are now permissible */
 	return 0;
-- 
2.34.1

