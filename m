Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DA2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 02:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiE0Czt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 22:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbiE0Czk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:55:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E0E8B8C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:55:39 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 190so3451372qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzG/UnfpEd7zrPeirqI9bxxqOPxgzzlm4lre7luGrs0=;
        b=TWayWQQdicVogsTlEFK5odfOJVF28f9lszqzOpYocvlt2tF2vvYb2AHtqaDVcf/kM2
         e9YYOp/mmdVE1x5Sb18AyiuDaJJXRwy3w4HdXWfvO82BiDEFAAjmX+kyxkcJypP88enE
         KZnuZ2LHoikplcxwefFgZzcV0ojbOoLyiPJsFf9p2yc+s3Z3BBpzv0FuX4hojzjEjHwC
         76ew1uT+3Mr3DGHdkRuuoiX9xZL1UhKv1uFVxQtXnmJfyutqzWmllFrQR0ETZfiHFrQw
         LzhpywQs7m/zXlEFC9KOzNdZO6pVUA7uYMSRXyFYYagANq6l2OPUR3/xiX4cEH3MTrZv
         PFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzG/UnfpEd7zrPeirqI9bxxqOPxgzzlm4lre7luGrs0=;
        b=MH85Van7kUS5xnbH4/pCC7enH8BO/7jh+yt5WOn2LydMO7eXwae3nhg8uMHLC2DOIr
         U19YeB0XEJn2VJEVzS/rvV2+2mzc67tedho60wE2Xw/jxeleB47NEJQUrsDyPlJ7+1w4
         XPyLzVd5XqfqKwnEoRmVK9u2bzQZv3t9GM7hlrPczZWgECOE5aZ29RJ23tkMK6KbSQHg
         u0pyT4xuZpx6MxEMmMSB2Jo0nMCk0Cxbnzpvbl3mURXBO3jC4r/DxTW1CeP5smlwN1j7
         CBq+9lDoaWqSCfcro11w0ZuLtJHLJaimAmlYmJ0fQyFecAXF/v1TpwFF/hFIWXHIrhPE
         C8Hw==
X-Gm-Message-State: AOAM5334cKCzUq6FAPqDhxFodebsH4rNLnC5nw6NqkjwJ4Ci4Cp34Dr3
        LinNHaOR/b5On+Gadm4NP2bq8g==
X-Google-Smtp-Source: ABdhPJwUqeyvHjYiti4yPhL4/c5gSOC9pYngAjeKK51N+f1LZWyIBnav+8a4aO4rCqX0RtL6GQWQ4g==
X-Received: by 2002:a05:620a:28c1:b0:6a5:ba25:1768 with SMTP id l1-20020a05620a28c100b006a5ba251768mr3643291qkp.464.1653620138787;
        Thu, 26 May 2022 19:55:38 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id r129-20020ae9dd87000000b0069fc13ce224sm2129672qkf.85.2022.05.26.19.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:55:38 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, rburanyi@google.com, gthelen@google.com,
        viro@zeniv.linux.org.uk, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Allow to kexec with initramfs larger than 2G
Date:   Fri, 27 May 2022 02:55:33 +0000
Message-Id: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the largest initramfs that is supported by kexec_file_load()
syscall is 2G.

This is because kernel_read_file() returns int, and is limited to
INT_MAX or 2G.

On the other hand, there are kexec based boot loaders (i.e. u-root),
that may need to boot netboot images that might be larger than 2G.

The first patch changes the return type from int to ssize_t in
kernel_read_file* functions.

The second patch increases the maximum initramfs file size to 4G.

Tested: verified that can kexec_file_load() works with 4G initramfs
on x86_64.

Pasha Tatashin (2):
  fs/kernel_read_file: Allow to read files up-to ssize_t
  kexec_file: Increase maximum file size to 4G

 fs/kernel_read_file.c            | 38 ++++++++++++++++----------------
 include/linux/kernel_read_file.h | 32 +++++++++++++--------------
 include/linux/limits.h           |  1 +
 kernel/kexec_file.c              | 10 ++++++---
 4 files changed, 43 insertions(+), 38 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

