Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC81C28D13
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 07:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbiHYHkW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiHYHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:40:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA49C1CA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:40:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m1so79307edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nLgYgBZv4Ojie5IT52w9APyhpkfyBxlvpeMEG5br3b0=;
        b=hF1cSyp6RBBohDv1oesTIwpASQmIxKugq5RMW42oRcRIAVIXXBjJuORElZ/e6LjSvd
         S6CeZdGjW5Fsn6YJLgLeeNyLZyhHNcClYrR7zB5R1DsZRacS07FublchEh6HbR66NTLG
         zPE6Sjr/z4NE/LI7/ayRjT0m/wuw4kvQt7Qgs0RKgqkej1pjaAyjnYI8CKDxbZZfxGsh
         +zuRMNYvsqtt6mMouk1GyXT0/s6iUm9uu45jMXgZLl7DoG+M/05tKptMmV9HTEQN7xD7
         Zz4PjaOrfMpSQpCMWedGTT7hXcqQ+L0Ws8ymHcD6ZMfP8+QMY5nbZPxkq5djxTyDkfIc
         fQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nLgYgBZv4Ojie5IT52w9APyhpkfyBxlvpeMEG5br3b0=;
        b=m84OT8+En1KLRr99Zw59IN8FXGkPiN/9AlqqnTFzAIF8849zWESw1a0vx3s6U9t+v1
         G2kzzZbP/ivjOWaWKrRXlZW/vdXq/Goc+qURNKMZp59Ek4cSRzkhEDFgjtSR105YjBHA
         c5mjBusbjzVuUyYhM8zqD3gbIfKndVmJM+ak65kZ/z+KJbSBMpZFCE/7oxJRn7OG1yEh
         DO+RHkmScTkHPdeYo4jX7ddsrirMSwCNHzsFjHYZbBwHH9ADZyA5sdZtzOwDyeBeoTV5
         SlUlmAJ8TS1xtiIMHnhgJQN4P/zSGkbwQtByv29B81pE4awUD17u0rXP17WhCkN+i9lM
         HMLQ==
X-Gm-Message-State: ACgBeo2Oo1mcxe4OFyMojG/wjy+KIp8bbhery9MiVI7MbBhA2p7U9d9/
        eel4yhxKqD2zXEeD7FkHl8y7hg==
X-Google-Smtp-Source: AA6agR6iWaAWt83JulaknQIPGkAB7ve4B5dEcbKVHbYqeNKuexjnXc7bp0LJkYtV/6k+3iyIKmGBIg==
X-Received: by 2002:a05:6402:450c:b0:443:6279:774f with SMTP id ez12-20020a056402450c00b004436279774fmr2103576edb.11.1661413211451;
        Thu, 25 Aug 2022 00:40:11 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id jg31-20020a170907971f00b0072b3406e9c2sm2106267ejc.95.2022.08.25.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:40:10 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: jz4740_mmc: Fix error check for dma_map_sg
Date:   Thu, 25 Aug 2022 09:40:08 +0200
Message-Id: <20220825074008.33349-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825074008.33349-1-jinpu.wang@ionos.com>
References: <20220825074008.33349-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mmc/host/jz4740_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index b1d563b2ed1b..dc2db9c185ea 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -298,7 +298,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 {
 	struct dma_chan *chan = jz4740_mmc_get_dma_chan(host, data);
 	enum dma_data_direction dir = mmc_get_dma_dir(data);
-	int sg_count;
+	unsigned int sg_count;
 
 	if (data->host_cookie == COOKIE_PREMAPPED)
 		return data->sg_count;
@@ -308,7 +308,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 			data->sg_len,
 			dir);
 
-	if (sg_count <= 0) {
+	if (!sg_count) {
 		dev_err(mmc_dev(host->mmc),
 			"Failed to map scatterlist for DMA operation\n");
 		return -EINVAL;
-- 
2.34.1

