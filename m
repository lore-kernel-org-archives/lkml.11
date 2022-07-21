Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73DDC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 18:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiGUSBn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiGUSBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4608B4B4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91ECAB82622
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA955C341CF;
        Thu, 21 Jul 2022 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658426496;
        bh=HeHAa1GYP+Ezlk0vFf4+XDc2BHmt8PbK4OsvrkAKxhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oimh8exnFPGmXgG3prFkrvRQNqLzLwTrgsk08nN848l6xRggsmSi0L1eGDWxKKnip
         ndp/oLTE2eSi2YsZShgE4GJ3Upk3KiSbc8ZB1b0+3j1W1YEqhvEgVc2ntQ1t8vnFwe
         ykbkWTllt76UGR9qlEFiaOdyhqXNbLyIlmFdzINHTxWZuHIH1PLF+66wmBLDjWvEJH
         7vzIXzPGolGKMnWWgYKaNfl1154eT+ePaSFGoPqK4T+DusAKjei2o6JWdM/3MVQxn/
         +z2EI0Vk43Yz2eyBYGJaDld30wpepjxsjzuEGk+0AAqi6Ha4mUMAYt0XjTW/9zNDE5
         eaMUD54b5gVqg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] scripts/faddr2line: Add CONFIG_DEBUG_INFO check
Date:   Thu, 21 Jul 2022 11:01:24 -0700
Message-Id: <ffa7734c929445caa374bf9e68078300174f09b4.1658426357.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1658426357.git.jpoimboe@kernel.org>
References: <cover.1658426357.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise without DWARF it spits out gibberish and gives no indication
of what the problem is.

Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 57099687e5e1..5514c23f45c2 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -61,6 +61,7 @@ die() {
 READELF="${CROSS_COMPILE:-}readelf"
 ADDR2LINE="${CROSS_COMPILE:-}addr2line"
 AWK="awk"
+GREP="grep"
 
 command -v ${AWK} >/dev/null 2>&1 || die "${AWK} isn't installed"
 command -v ${READELF} >/dev/null 2>&1 || die "${READELF} isn't installed"
@@ -271,6 +272,8 @@ LIST=0
 [[ ! -f $objfile ]] && die "can't find objfile $objfile"
 shift
 
+${READELF} --section-headers --wide $objfile | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
+
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
 
-- 
2.36.1

