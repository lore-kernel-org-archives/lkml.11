Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECC0C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 May 2022 03:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiENDe6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 23:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiENDe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:34:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D219FBF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:34:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 129so5720781wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5QZWzuHTxmr/8kMUF9j6jV0ebxKJhFwcGInV9yBfEc=;
        b=LUTGaoXsVLhyfmwfwyjQGSBad/n9UD1T7JUVmt/gZu/PafGdABOUWS815yPR5KZ5R7
         ehdxfknxL92YC0p/NSoLhVHx5Bovi1ABbfkO114Ujr6GDPZRVQLblTe5EXejr/dUIIPs
         ZY8TWbzmBuxYRrhS9iF8XXXvsZ+D4CfMTRn687RDGhLuPSNTi8zhLuOKrFIwd6UYT5Q3
         NguceK8sjva2JdsrocesAI6dAc1Ty9aeZyCcAgZ5Uaso1vTgeetGjbV+NIIw3GoOC93y
         4CuxINEJCS6XFgrb5QnghNZqpE8F9vIpfUI9dTxQmXJNt7OnoSTFolEl5f4xPMIYL07W
         OOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5QZWzuHTxmr/8kMUF9j6jV0ebxKJhFwcGInV9yBfEc=;
        b=YDNsNGPOG1ohzLHghg2RfoOK0guR5esfITzTvs8SdbdUHdWE0G80aLhL5HICzHVS1W
         hc22bkLBYYCuKJbhZUfaodY8W4OUCXJ8u10YDv/PgUyfgmP2mvYvHV/KlfVdcSDnGt03
         W3ylmvsBl5FVoAzw1SKAYozUprA2xKBp3Snwzm3YxWz36+P8QWqwzQdT70L2czJvcRbd
         VEYO7axzPmwBd0Waw1CXBHtLvUWO1WrP8/MaVokUuwf8i7phJYifLrl9ysKFKKhTfrmp
         3vTO7G+AKE0P+EigEo8vvOOcgmYAzoIf3EE+Fretu+6n90dobOoivQomPWFVWj+W2hvM
         qDeQ==
X-Gm-Message-State: AOAM533cuy17HCsxTgE7QRGIDficWBUXRQVBijEnUUGWg3q+BuwkyQqh
        q9C7Wh4LdfCLWWTir5+PDuE=
X-Google-Smtp-Source: ABdhPJz2miU5m8FPapy2pIsPPGJwFNK06QXiIx73aq54BPFnwt6tgLD4YIjuqFWnTtxxHjvpp9LEuQ==
X-Received: by 2002:a05:600c:4e13:b0:394:797e:3358 with SMTP id b19-20020a05600c4e1300b00394797e3358mr17499210wmq.30.1652499293394;
        Fri, 13 May 2022 20:34:53 -0700 (PDT)
Received: from octofox.metropolis ([178.134.103.46])
        by smtp.gmail.com with ESMTPSA id h1-20020adfaa81000000b0020c66310845sm3542638wrc.55.2022.05.13.20.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:34:53 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 0/3] xtensa: add division by zero exception handler
Date:   Fri, 13 May 2022 20:34:34 -0700
Message-Id: <20220514033437.4182899-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds handlers for hardware and artificial division by zero
exceptions and improves call0 ABI probing in the presence of unrelated
illegal instructions.

Changes v1->v2:

- split ABI probing improvement from the artificial division by 0
- don't limit artificial division by 0 pattern detection to
  configurations without HW division opcodes, do it always

Max Filippov (3):
  xtensa: add trap handler for division by zero
  xtensa: support artificial division by 0 exception
  xtensa: improve call0 ABI probing

 arch/xtensa/include/asm/thread_info.h |  4 +++
 arch/xtensa/kernel/asm-offsets.c      |  3 ++
 arch/xtensa/kernel/entry.S            |  5 +++
 arch/xtensa/kernel/traps.c            | 50 ++++++++++++++++++++++++++-
 4 files changed, 61 insertions(+), 1 deletion(-)

-- 
2.30.2

