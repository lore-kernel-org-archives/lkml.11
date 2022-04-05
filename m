Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1AAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843182AbiDFBjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444337AbiDEPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:20 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9658895A19;
        Tue,  5 Apr 2022 07:04:16 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 235E2k8I021295;
        Tue, 5 Apr 2022 23:02:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 235E2k8I021295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649167367;
        bh=tlKllE+DeH+owxkSzZkT6wnBC6VcqxWAXsQhSEB8rk0=;
        h=From:To:Cc:Subject:Date:From;
        b=Uv4X9S8slbNYOacfNha8LhvGPEryM5kYHXmLEzvdr5IAfZaDURgz9esyRoB04c+5C
         hz1jkmpqUz+Ip3IV6aRBsB7/5c86PqqNgWgMijMJ0EdLZ3i2xMZoJZ1xXSqgcT6lKs
         ugNv2u7eEhu0EDi7YKN9ckmLl7vZnWW0x2mhEqtxgqv4zUsRWlam8hVy463NOjyUlf
         YmUqw4UJdABGIlAouutEFUA87PdtTb1qjRCFPWOGlPm8T5S7MBsTfsKLTyRBb3BNEw
         lefAHmSe4tGn9E2m39rmd8awrAPSD3hTlaxaAD+LT2E3/95Qmfmvmgh4WNANJMxMRP
         y7oEPJRf2fs4A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <n.schier@avm.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev
Subject: [PATCH v2 00/10] kbuild: misc cleanups
Date:   Tue,  5 Apr 2022 23:02:19 +0900
Message-Id: <20220405140229.2895394-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a series of prerequisite cleanups of my next work.


Masahiro Yamada (10):
  kbuild: factor out genksyms command from cmd_gensymtypes_{c,S}
  kbuild: do not remove empty *.symtypes explicitly
  modpost: remove useless export_from_sec()
  modpost: move export_from_secname() call to more relevant place
  modpost: remove redundant initializes for static variables
  modpost: remove annoying namespace_from_kstrtabns()
  kbuild: get rid of duplication in the first line of *.mod files
  kbuild: split the second line of *.mod into *.usyms
  kbuild: refactor cmd_modversions_c
  kbuild: refactor cmd_modversions_S

 .gitignore                  |  1 +
 Makefile                    |  2 +-
 scripts/Makefile.build      | 86 ++++++++++++++++---------------------
 scripts/adjust_autoksyms.sh |  2 +-
 scripts/gen_autoksyms.sh    | 18 +++++---
 scripts/mod/modpost.c       | 49 ++++++---------------
 scripts/mod/modpost.h       |  4 --
 scripts/mod/sumversion.c    | 11 +----
 8 files changed, 64 insertions(+), 109 deletions(-)

-- 
2.32.0

