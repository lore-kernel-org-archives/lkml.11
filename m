Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ED0C25B0D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 04:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiHPEsw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 00:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiHPEpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:45:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D654C61B17;
        Mon, 15 Aug 2022 13:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43A52B8113E;
        Mon, 15 Aug 2022 20:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99882C433C1;
        Mon, 15 Aug 2022 20:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660596140;
        bh=n53XmxCgwLMlqFZN8KbH07lCxfM9RjyR4HTH0+4uqBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYBX4Chsa1s/S5BPefboKoz8Q2oqz+/N3jc3rtfKR/vH/QT1AdMnCfcKr2l6XaLsh
         DyficWFi/45nk6ebI6qE6jGs6jSVugy7dW7U1n8DZ4xW7cFKT2KJWtPVs/5FMVcW8g
         aJtHtqC7ktNhM7mriVi5WAsSRVgp+iqLtu7gdJMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 0986/1157] watchdog: f71808e_wdt: Add check for platform_driver_register
Date:   Mon, 15 Aug 2022 20:05:42 +0200
Message-Id: <20220815180519.176030437@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 97d5ec548150764946f38632e62e79759832b54b ]

As platform_driver_register() could fail, it should be better
to deal with the return value in order to maintain the code
consisitency.

Fixes: 27e0fe00a5c6 ("watchdog: f71808e_wdt: refactor to platform device/driver pair")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
https://lore.kernel.org/r/20220526080303.1005063-1-jiasheng@iscas.ac.cn
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/f71808e_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 7f59c680de25..6a16d3d0bb1e 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -634,7 +634,9 @@ static int __init fintek_wdt_init(void)
 
 	pdata.type = ret;
 
-	platform_driver_register(&fintek_wdt_driver);
+	ret = platform_driver_register(&fintek_wdt_driver);
+	if (ret)
+		return ret;
 
 	wdt_res.name = "superio port";
 	wdt_res.flags = IORESOURCE_IO;
-- 
2.35.1



