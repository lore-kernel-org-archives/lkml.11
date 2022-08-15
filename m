Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1F0C32763
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 22:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348757AbiHOWVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 18:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349634AbiHOWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7192C115;
        Mon, 15 Aug 2022 12:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6BC86120F;
        Mon, 15 Aug 2022 19:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A404DC433D6;
        Mon, 15 Aug 2022 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660592420;
        bh=OBgG/fVVKPQLvqHzjSlNXO7UyFxMhf3DO59n0ZEWzTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRh8mQfu4PVUA2i2hk8g8fdTPVsrUeZWEmH5GFARgsKS89cyiP9+4CXMNidAHztyJ
         gjy+VLed2jojJmNLutfHcrTDyU5ik37163Qkb3NujxEIG91riXILIHBR7kUNPYzlmX
         4vvs/mpXbAJNg9tCiUwUFCRD0ESna6BmWk3FGK68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liang He <windhl@126.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0784/1095] mmc: core: quirks: Add of_node_put() when breaking out of loop
Date:   Mon, 15 Aug 2022 20:03:03 +0200
Message-Id: <20220815180501.696161709@linuxfoundation.org>
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

From: Liang He <windhl@126.com>

[ Upstream commit 883c1d6fa4368a63cae2d6ae2d9c91141c60e233 ]

In mmc_fixup_of_compatible_match(), we should call of_node_put()
when breaking out of for_each_child_of_node() which will increase
and decrease the refcount during one iteration.

Fixes: b360b1102670 ("mmc: core: allow to match the device tree to apply quirks")
Signed-off-by: Liang He <windhl@126.com>
Link: https://lore.kernel.org/r/20220719091051.1210806-1-windhl@126.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/quirks.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index f879dc63d936..be4393988086 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -163,8 +163,10 @@ static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
 	struct device_node *np;
 
 	for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
-		if (of_device_is_compatible(np, compatible))
+		if (of_device_is_compatible(np, compatible)) {
+			of_node_put(np);
 			return true;
+		}
 	}
 
 	return false;
-- 
2.35.1



