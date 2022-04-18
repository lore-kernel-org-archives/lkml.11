Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545FCC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 08:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbiDRIUZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 04:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiDRIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:20:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE8A167D6;
        Mon, 18 Apr 2022 01:17:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l7so25656926ejn.2;
        Mon, 18 Apr 2022 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7KtsXjPh9lfFnODrrFCb9+TsBoLzX4dD8HDH0L28ETo=;
        b=qGvm/KPaMmFmxeZQ9Ci1YPmBGPqYHItSqLu2nR0o7qsOBNcHjBa173id0xrm17VBJG
         9SbkEWiHhoF7oPOJ8N+kwFWqBIUAjwnW6a1A56mOxc1woFJT2MDOGFJ3cMe6Ugfo/t2Z
         DUwHEPpRk8hncMUuxz0lykj9cS7afW2on5arFNggQqo8M2W6v1Gf7KBXuoQOB2sGb4xG
         qQEoMZSRDXbf6Wom/OCRdkORGdR6s+NHLG0loaaKYkezAJsPUrldfe2sNxEliP+owy/t
         sHTMBTybK6EeByHtu0SAwFaBJkcVTMfLBXpDpVKfBf0qnPUBcsOFWi1E90IZwpv9ncY2
         8BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7KtsXjPh9lfFnODrrFCb9+TsBoLzX4dD8HDH0L28ETo=;
        b=jDmvGFB3/DhV++Yw6JdvGHrQKEUr6l+Q7xpXjqg8PPpW7HBt3uoqa/8c1Tlfuy+u96
         QVP8IGkPVQOXfg0oRd/qIzg3Obt7CIBDQ4BvjZBpy1SetPCtZFKokA/cdJ0OoXL5c72Q
         S8IsMAwRgtm7toIg42ioP6hhuXwVVhREgGAZBc1CvQv8mMfUayfp2TSM5g0Nl3t/0K1s
         RAlJcZkdI8S2luCmpz4/jmKGf4kSq4o5sdU5TXapJEVinoWUG2bcCRMnDgjFWtaB/fQ+
         gTxLwhlxiJKIBVwilC+BO80xZMeVba9np2QHc442uZgWDpPSdFxRv792bu490wUQO1J5
         expg==
X-Gm-Message-State: AOAM530bK6kodHGxGPeZ6EyYgv/lMfTUC8Ypzp3cd8KonuMuctQBFbNZ
        52Xls5vFtTUmkXUVA00AiWk=
X-Google-Smtp-Source: ABdhPJzs0nbDO3Ua/XZPtya90bEQnjKykEsVRVQvWzz/925zERd1qCgU2TBxRtja+LwOMrTNL2p+hQ==
X-Received: by 2002:a17:907:2d23:b0:6e8:807c:cd94 with SMTP id gs35-20020a1709072d2300b006e8807ccd94mr8085785ejc.502.1650269864091;
        Mon, 18 Apr 2022 01:17:44 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm4346365ejy.37.2022.04.18.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 01:17:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] Documentation/vm: Include kernel-doc from highmem-internal.h
Date:   Mon, 18 Apr 2022 10:17:40 +0200
Message-Id: <20220418081740.21001-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Documentation/vm/highmem.rst the kernel-doc comments are missing,
therefore kunmap_local() and kunmap_atomic() are yet undocumented.

Add a kernel-doc directive to include the above-mentioned kernel-doc
comments in highmem.rst.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This patch must be applied and built on top of 
"[PATCH v3 2/2] Documentation/vm: Include kernel-doc to highmem.rst"
https://lore.kernel.org/lkml/20220415231917.25962-3-fmdefrancesco@gmail.com/

 Documentation/vm/highmem.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 5dcee6233cd5..1a3e6a8f5d3e 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -161,3 +161,4 @@ Functions
 =========
 
 .. kernel-doc:: include/linux/highmem.h
+.. kernel-doc:: include/linux/highmem-internal.h
-- 
2.34.1

