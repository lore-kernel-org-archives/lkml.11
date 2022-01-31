Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBBDC4167D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Jan 2022 11:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376453AbiAaLI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Jan 2022 06:08:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39646 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359331AbiAaLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:05:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0425F60FD2;
        Mon, 31 Jan 2022 11:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4085C340E8;
        Mon, 31 Jan 2022 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643627111;
        bh=z3hZqaG3OAOpTGubGmzQdXcuX5HhIvzRJ1/enbB/OB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnvBcVYL9CGRZSiqjq9I/ROrQjPTTpN0pU51B8L0iwuaZQBJxmurYBdb+LzAxvSyn
         wQpbxBExEnt+qQGF8I9bxxMYi2bnbQErfPSQ1huQEYHaOHwj+rphs4jvncT9q7HQ9k
         ufUkkHQTkOHgk/muabH4WuZ2c/r8RQvwE+BSvoN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Lehan <krellan@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 078/100] hwmon: (lm90) Mark alert as broken for MAX6654
Date:   Mon, 31 Jan 2022 11:56:39 +0100
Message-Id: <20220131105223.055021917@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131105220.424085452@linuxfoundation.org>
References: <20220131105220.424085452@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit a53fff96f35763d132a36c620b183fdf11022d7a ]

Experiments with MAX6654 show that its alert function is broken,
similar to other chips supported by the lm90 driver. Mark it accordingly.

Fixes: 229d495d8189 ("hwmon: (lm90) Add max6654 support to lm90 driver")
Cc: Josh Lehan <krellan@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm90.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index fef02bcfedbcf..6841d0401bbd4 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -400,6 +400,7 @@ static const struct lm90_params lm90_params[] = {
 		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
 	},
 	[max6654] = {
+		.flags = LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
-- 
2.34.1



