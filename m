Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED0FC46467
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346568AbiDEKne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiDEIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B8B8E;
        Tue,  5 Apr 2022 01:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BFBAB81BCE;
        Tue,  5 Apr 2022 08:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B0DC385A2;
        Tue,  5 Apr 2022 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147310;
        bh=vNZad3FPjoAjHReFNNmD0sSgxbCTGXb4aPBNRc7b06Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYJ7dZC31tYrlYGfJhmdyUKDqDQMMZYnIY2Y8tBYaoxivIs31UAISA0+ObRPjGsL9
         yrWXNBNLw7/2BARoj/V17yapCJkgN18Uvm1gjt60N4tfyz58bDFLXUs4I0tP9HQQC0
         ermsBAh85zcAjG2fOdKdQWVBUlTCoY4X0loKXKqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nemanja Rakovic <nemanja.rakovic@syrmia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.17 1077/1126] mips: Enable KCSAN - take 2
Date:   Tue,  5 Apr 2022 09:30:24 +0200
Message-Id: <20220405070439.066740821@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nemanja Rakovic <nemanja.rakovic@syrmia.com>

commit d1ca45f93c3f95d1590d60b012cf8fcf6db633ee upstream.

Replaces KASAN_SANITIZE with KCSAN_SANITIZE in
boot/compressed/Makefile.

Fixes: e0a8b93efa23 mips: Enable KCSAN
Signed-off-by: Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/compressed/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -38,7 +38,7 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__AS
 KCOV_INSTRUMENT		:= n
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
-KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswapsi.o


