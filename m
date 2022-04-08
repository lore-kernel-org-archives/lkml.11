Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4434FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 01:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiDHBPA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiDHBO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:14:57 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE0B12BFA5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:12:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso5112947otd.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5T80dpqvmJyYNxCZPNBDf8/a2ZuY3TCPiPd35SWGCc=;
        b=E7OoQvNxDDe09i6QR9xdARsM79ePm/M/GnhEUuka5ePvPKmxSzVeCIx+NOUan7gbw2
         hMmdroWzjdnnUoL5vl3SlKGQdmfvw3WdfpaepUJDo4sqOjA4eRXh4JTCoA09a+sE/qsT
         CgoOQ1qVoshjmzOnAv/Pml3JdvMwX/O4IH5Z7aBAKVtA2iS/EAcdXfyzCGRZB8dcKaey
         OxKq8aOE4x8UQe2KPOep/afFdjryf7N8sOLfozrnDfirinDtqBvZvFES4+LkdfM+wRrd
         ZosfM1M8JCbtiWobaI5NYqCK2opbrLQunPVUWQi0xBUzYHypkKtzRukNwQqSG+F8QYLe
         B1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5T80dpqvmJyYNxCZPNBDf8/a2ZuY3TCPiPd35SWGCc=;
        b=5QgDbp9eLbg1jhvs2oPf3p2DsdvPlbbzulJ6aHo2i8nhHZ5abkLBWPQbkfh9IfCJ+J
         me43hNrI0z/X5pdavjB6T1mgt3zz+T8GNugHbyr9ruWO4sg4e780Wqc1MJSwjaKUEGyi
         b3pJ71Xj91i7xuVnoFdnsVp+jVZ1puybJ+4PQrnktUTOiwfd4GPS/l8Mux6o7oTi9Nzp
         C8F00iY3V1y43Ddki3EZNHGI1ZJrpL6+ekj8ZUq7oE9hZe13V2APm3oZ9IPLIidETJYk
         9GDpvgGfaqw18+W2NC5uZMNqaftFml6bGnG+SyGXtKj3L0gbOLHwouOiRmfem5JCZzS6
         dR4Q==
X-Gm-Message-State: AOAM533jX0QUoglGBEriBCcwSw+VtyuJF1RE1nRmVg5xU8pQy3SOmNG6
        31yz877cxfdjXfMHuDSRi/c=
X-Google-Smtp-Source: ABdhPJzWZsVb+0FBT/UfuuBz57l2HrHGbM/x5tYjidzAbn3d6nHElcTM6GoDapqOrADJyP07SvO7WA==
X-Received: by 2002:a05:6830:4cb:b0:5ce:889:bc4e with SMTP id s11-20020a05683004cb00b005ce0889bc4emr5848652otd.87.1649380375606;
        Thu, 07 Apr 2022 18:12:55 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id 190-20020a4a0dc7000000b003244ae0bbd5sm7795463oob.7.2022.04.07.18.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 18:12:55 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 0/2] staging: rtl8192u: cleanup of ternary and if else statements
Date:   Thu,  7 Apr 2022 20:12:49 -0500
Message-Id: <cover.1649378587.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches replace ternary and if else statements with
more readable statements. Found with minmax coccinelle script.

---
v1 -> v2:
* Patch 1: "staging: rtl8192u: replace ternary statement with if and
* assignment"
  * replaced max macro with an if statement followed by an assignment

* Patch 2: "staging: rtl8192u: use min_t/max_t macros instead of if
* else"
  * changed the type argument in min_t and max_t from u8 to u32
---

Rebecca Mckeever (2):
  staging: rtl8192u: replace ternary statement with if and assignment
  staging: rtl8192u: use min_t/max_t macros instead of if else

 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c   |  4 +++-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 13 +++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.32.0

