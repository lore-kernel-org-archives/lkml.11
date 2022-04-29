Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BCBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Apr 2022 16:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358596AbiD2Qb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379137AbiD2Qb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0767DA6C7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i5so11435230wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ks7iNdCfAtLHcGFxak97bEFI2RXZViTgEPfvTdzl5nU=;
        b=dcrihyw7I+gZu+S9NN3riDHd9b3CQ04ZfaxESSQCra//U0lJECoeySkwNG1ude/TfU
         A9U4vJoBKQnOBaLGhcOFfOdVRT5FZRUtBr2rCsHFb1//NoCz7/rdNckOpZKl71M/vv1h
         s2iX46rrsmoNvC2LYA0yeNVHp9bnvcxDhSv/9Uc/MVJ1dymfBh5Uq5J3WFaxee1WC5kl
         IVA8+ZApuQpdXQfc25lBu1fusenAcdO+tCySnaB5QtvsZJcnSSy1m80bO/22Mt1muRyE
         7CqtPAput/GLy2JgMyw6Le8/F6UoRk91Cd/O/NzpY522avBwU6IWUtw5Bi28Gnrr6Q9X
         N8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ks7iNdCfAtLHcGFxak97bEFI2RXZViTgEPfvTdzl5nU=;
        b=mcwn9GKZzw07DKMidoAK7qbU7vR8ds9ATcIzOxaYqYmt73VfaY6RzzEEhXx5eZjlbk
         njqBc2tj2L95doJTvjcgy3dwCupBwPrSLOqxO6q8dKMzH38X3XNvREmWaT+Nd6jclnUa
         TOqLQsQ0mqXt7TXHVZD+S6pRPYsHXhr7zq81L9ZnIb1k3kByBf7lDuvgDal9UQQ8Jh90
         gIzwdKcuqUYvChNrDu+TcIeEp9fzpn36knWMFx4lrKtHzsU7Y5sbcwFpazmftcnDobgj
         gRH4qGXHyHeQ+IbgF3aApkNceHIWFhxAbluTEp037ibEurSrc+yY4CseZY7+g4ctAtt5
         XqgQ==
X-Gm-Message-State: AOAM532X/pQG86BkrdKUOeCUyki9rw9IZskq9gutE6Nnfmc/cPcZhsol
        mjyM2+1uJsS1AYbFWjkPe0c4ow==
X-Google-Smtp-Source: ABdhPJw+ZAPatvN0NekMZbg5R/AEupkitMkm/KukTtWd6BNWGD3KSvx4+uKxGWZA32WtVKwCfvbHUw==
X-Received: by 2002:a5d:6c68:0:b0:20c:4af0:cad9 with SMTP id r8-20020a5d6c68000000b0020c4af0cad9mr2694501wrz.41.1651249685564;
        Fri, 29 Apr 2022 09:28:05 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/16] nvmem: brcm_nvram: check for allocation failure
Date:   Fri, 29 Apr 2022 17:26:55 +0100
Message-Id: <20220429162701.2222-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

Check for if the kcalloc() fails.

Fixes: 299dc152721f ("nvmem: brcm_nvram: parse NVRAM content into NVMEM cells")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/brcm_nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 450b927691c3..48bb8c62cbbf 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -97,6 +97,8 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
 	len = le32_to_cpu(header.len);
 
 	data = kcalloc(1, len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 	memcpy_fromio(data, priv->base, len);
 	data[len - 1] = '\0';
 
-- 
2.21.0

