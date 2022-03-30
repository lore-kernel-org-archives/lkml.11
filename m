Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94402C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 15:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbiC3PaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348209AbiC3PaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:30:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716F1E520E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:28:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r64so12486043wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7wOiTq1PLXPUAGj3bM3pfG9fYquFxGpWIhhZ6fy3tcs=;
        b=eSqNBQuX9r/9GTv8TKX8urolhRUwZliSSjWypLgFlBG5+kY/7y7qLZqe9nIOeKBVAb
         kzHlCI0iN9baILYN5MWV2n8lGmE3+L6iIhR4AizQWPw5ac6AIIXunDvJrYZQDAI2Th+F
         D1zrDQniNmDUZoJPAQTFNIEq9Ii6Kek0Q2StPWaGZxyL3lA8o1v71Uq0YQQCUXJ8jEe/
         gL/bGZGwyPpr2TPgj7BP8YU2QOA7DdtKLXJkY+KBRulXY5k+1Gk2Q+/TAvJNNzxaeZnu
         +k5xrH6ypPmqUbP8RTr0DSYJop9T2IqUrJQEegWsQZY2sJgAYNp12t37gYNyvx6hkKes
         gZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7wOiTq1PLXPUAGj3bM3pfG9fYquFxGpWIhhZ6fy3tcs=;
        b=E8vK7nuAGuSCyVitnB6eRIwgZHwLWH/bn3UvtMQbRWy+/lcPRyNzII8+RX57uoNnzU
         PG8cpr2ADgXE80BBMlIVusGCTZtbqy7E/XP5wyD8CJJhw4cHaMo+OU7Ehca2YfSa3H4c
         +dJMzjzKvfZLwDzbrQJXY3wOVz0x7oRs+RAZulwTD0868aO/on0UYH+DMUoVLJFZZyn2
         CNgsbZk6jVwV9GNtbIe7c4bnCktu2As1D9E9cfwpTLWreHXoO4HylIKa2PJj/5gtrb1l
         GA5eHy3+2pMHCKN33Tg8Y15flAveWmOAnXU9+siR5Id6fSOtAtNQiYZNdLgBl23G3Bt4
         8EtQ==
X-Gm-Message-State: AOAM532rHcB1aM94D7itq4iT89SG42QmbKeYVkntH6+lCw7eW0hIu7+T
        ntMWCuW459w1+uSeJVZz/ouk1qlG8r04XvR/
X-Google-Smtp-Source: ABdhPJxi3IiRwS66oW+/pDWCojnAynkSTFUbFs2BpuHgzx6MviZGIIGN/Czs+uKP0xdIiLhYpGlrsg==
X-Received: by 2002:a05:600c:321a:b0:38b:c418:4d09 with SMTP id r26-20020a05600c321a00b0038bc4184d09mr4943133wmp.181.1648654097086;
        Wed, 30 Mar 2022 08:28:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:e47f:3cdb:5811:cee8])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c349200b0038ca453a887sm5254097wmq.19.2022.03.30.08.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:28:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] x86: undef REG_IN/REG_OUT to avoid define collisions
Date:   Wed, 30 Mar 2022 17:28:08 +0200
Message-Id: <20220330152808.1461758-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These defines are only used in the inline functions declared
in the arch_hweight.h file, and collides with internal defines
of the Amlogic Mes pinctrl driver when COMPILE_TEST is enabled:

arch/x86/include/asm/arch_hweight.h:9:17: error: expected identifier before string constant
9 | #define REG_OUT "a"
  |                 ^~~
drivers/pinctrl/meson/pinctrl-meson.h:69:9: note: in expansion of macro ‘REG_OUT’
69 |         REG_OUT,

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/x86/include/asm/arch_hweight.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..139a4b0a2a14 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -52,4 +52,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 }
 #endif /* CONFIG_X86_32 */
 
+#undef REG_IN
+#undef REG_OUT
+
 #endif
-- 
2.25.1

