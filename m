Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2C4C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 20:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbiHOUo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347418AbiHOUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C1FB2D8C;
        Mon, 15 Aug 2022 12:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB0C61267;
        Mon, 15 Aug 2022 19:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C0DC433D6;
        Mon, 15 Aug 2022 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660590475;
        bh=IKW68nveAglgeNnym+vgT6nzaVOyqVoVUfARrjdeb+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1wXMgnUvRo22haBHJ9aY6pCNbEebZT9uRL101UWsPcPjlOvXYOw2culHu6IVWcq/
         z7FOYXqzYTRFfyKVf+vch+kwgiBf4rAYWJKP1DtOSdej3ePK6jhn4oi1mAwaLU+GjW
         AYmNky/fhL6EbAJKDoNNtUw1RTnyEBEFQw8HX4sU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0272/1095] hwmon: (drivetemp) Add module alias
Date:   Mon, 15 Aug 2022 19:54:31 +0200
Message-Id: <20220815180441.005801701@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 5918036cfa8ded7aa8094db70295011ce2275447 ]

Adding a MODULE_ALIAS() to drivetemp will make the driver easier
for modprobe to autoprobe.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220712214624.1845158-1-linus.walleij@linaro.org
Fixes: 5b46903d8bf3 ("hwmon: Driver for disk and solid state drives with temperature sensors")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/drivetemp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 1eb37106a220..5bac2b0fc7bb 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -621,3 +621,4 @@ module_exit(drivetemp_exit);
 MODULE_AUTHOR("Guenter Roeck <linus@roeck-us.net>");
 MODULE_DESCRIPTION("Hard drive temperature monitor");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:drivetemp");
-- 
2.35.1



