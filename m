Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA54C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 21:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiGLVqC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiGLVqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:46:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7520A58C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:45:59 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6416266015C4;
        Tue, 12 Jul 2022 22:45:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657662358;
        bh=IHenW9H7ZxGU905n2XgP0AlaR9jUMs4T5Bm5awMEA/0=;
        h=From:To:Cc:Subject:Date:From;
        b=i0S1jGP6Z+4WBNl/9P4yI8+sBw0TVXK/aXG5IuI0OU3KWL8ENeRUFmFKSBF78nRvG
         +Bmj/wnKRxdtOrApL5PW/+p3M/zO7NNY1IjSTVdk7LlpQulTtUgiwe3N79xYGkhnp6
         uX+0RYD2nfB+csGoBGthFb7pagjGcS0S4onR8ANu70Qg6oT5w+9KUHLEAYoXb/1UbW
         gsZ1kWErQGf2VEHxVDqGNWDvEkX7/KWXLI/6StHctB4g8Qc1qRI/d90GgbUi44dM9Q
         K0+nIyJXlEHv7rSwRzpEUyvyHzOXuRjfPFhtmrAr4BrSHif5fvm20OIlUZFGdXi1MU
         lKD5ClvT4D9Cw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_typec: Use dev_err_probe on port register fail
Date:   Tue, 12 Jul 2022 17:45:54 -0400
Message-Id: <20220712214554.545035-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typec_register_port() can fail with EPROBE_DEFER if the endpoint
node hasn't probed yet. In order to avoid spamming the log with errors
in that case, log using dev_err_probe().

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d6088ba447af..8c0ca3c128ee 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -352,8 +352,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
 		cros_port->port = typec_register_port(dev, cap);
 		if (IS_ERR(cros_port->port)) {
-			dev_err(dev, "Failed to register port %d\n", port_num);
 			ret = PTR_ERR(cros_port->port);
+			dev_err_probe(dev, ret, "Failed to register port %d\n", port_num);
 			goto unregister_ports;
 		}
 
-- 
2.37.0

