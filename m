Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986F7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiF0L3X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiF0L2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:28:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41876587;
        Mon, 27 Jun 2022 04:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24796B81123;
        Mon, 27 Jun 2022 11:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5825BC341C8;
        Mon, 27 Jun 2022 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329244;
        bh=lkdp9TG2/+HjYn1m8Nr4MRQIkow3L5qBfoi9/2E0Trc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sO2jvOmaDBnEPtHCa9NqK2jLz7uvuzbAB3MrahEQ3Vsq94qagI2YxdR/6DRv4vIbH
         zpmgSf7y65JTfoA5OoV3F3laToYcVW2DivUR4lpdRKoDFgWyFiZiBZCrvVOD9OuXeK
         GrdvPml4hDpjUyMa5ixboAKpKWbJ+I7wUKxX5YyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 5.10 099/102] modpost: fix section mismatch check for exported init/exit sections
Date:   Mon, 27 Jun 2022 13:21:50 +0200
Message-Id: <20220627111936.402838961@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111933.455024953@linuxfoundation.org>
References: <20220627111933.455024953@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

commit 28438794aba47a27e922857d27b31b74e8559143 upstream.

Since commit f02e8a6596b7 ("module: Sort exported symbols"),
EXPORT_SYMBOL* is placed in the individual section ___ksymtab(_gpl)+<sym>
(3 leading underscores instead of 2).

Since then, modpost cannot detect the bad combination of EXPORT_SYMBOL
and __init/__exit.

Fix the .fromsec field.

Fixes: f02e8a6596b7 ("module: Sort exported symbols")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/mod/modpost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1119,7 +1119,7 @@ static const struct sectioncheck section
 },
 /* Do not export init/exit functions or data */
 {
-	.fromsec = { "__ksymtab*", NULL },
+	.fromsec = { "___ksymtab*", NULL },
 	.bad_tosec = { INIT_SECTIONS, EXIT_SECTIONS, NULL },
 	.mismatch = EXPORT_TO_INIT_EXIT,
 	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },


