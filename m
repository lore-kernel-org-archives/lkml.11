Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95FC4167D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583245AbiDEXvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354111AbiDEKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:11:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C504506DE;
        Tue,  5 Apr 2022 02:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F0F2B81B13;
        Tue,  5 Apr 2022 09:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9947AC385A1;
        Tue,  5 Apr 2022 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152636;
        bh=M22wOKUpekKpognQbIgFpkF7FL2nVQ5DecRYMgd2GuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lw+ck9sZa/GaKHUCH0u/WWNn0OITLc8JPCHWofrBCyBd5hHjmBJI1KgTNR9Gqawvf
         aovUm+LT4+nPMOzjrWdHjJFAYCWfPWcLZt+b3tXUwJPq8E7/HlocZBiHXLWj7pj46I
         3GN5wjLHbehx0S82eJxUc27k9oMIVyChT1cVQJfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 5.15 848/913] watchdog: rti-wdt: Add missing pm_runtime_disable() in probe function
Date:   Tue,  5 Apr 2022 09:31:50 +0200
Message-Id: <20220405070405.247995032@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

commit d055ef3a2c6919cff504ae3b710c96318d545fd2 upstream.

If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220105092114.23932-1-linmq006@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/rti_wdt.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -229,6 +229,7 @@ static int rti_wdt_probe(struct platform
 	ret = pm_runtime_get_sync(dev);
 	if (ret) {
 		pm_runtime_put_noidle(dev);
+		pm_runtime_disable(&pdev->dev);
 		return dev_err_probe(dev, ret, "runtime pm failed\n");
 	}
 


