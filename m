Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC45C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351884AbiBUJqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:46:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352148AbiBUJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:38:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC9321823;
        Mon, 21 Feb 2022 01:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83536CE0E8B;
        Mon, 21 Feb 2022 09:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA0BC340E9;
        Mon, 21 Feb 2022 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435016;
        bh=h+6ax31lByBfHCOkSaM6gKDPC7nJTAqO45ye6NNozzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNrvZLwkAz7QcQstnF8NavR3jKviEWSSriLdELwmYxOe8C2SBnpg2khk0lTOjJM6E
         5HrcDzqsartmASLRMlac4NtlXw6PUJXCPrbYZXXxVCIzNwcAqi3qSNAVlRGjbN9TH6
         009ui/GBGlcH+haGHg1GRi7ku+/zhYlYCgroUlTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.16 015/227] parisc: Drop __init from map_pages declaration
Date:   Mon, 21 Feb 2022 09:47:14 +0100
Message-Id: <20220221084935.346800321@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John David Anglin <dave.anglin@bell.net>

commit 9129886b88185962538180625ca8051362b01327 upstream.

With huge kernel pages, we randomly eat a SPARC in map_pages(). This
is fixed by dropping __init from the declaration.

However, map_pages references the __init routine memblock_alloc_try_nid
via memblock_alloc.  Thus, it needs to be marked with __ref.

memblock_alloc is only called before the kernel text is set to readonly.

The __ref on free_initmem is no longer needed.

Comment regarding map_pages being in the init section is removed.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/mm/init.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -337,9 +337,9 @@ static void __init setup_bootmem(void)
 
 static bool kernel_set_to_readonly;
 
-static void __init map_pages(unsigned long start_vaddr,
-			     unsigned long start_paddr, unsigned long size,
-			     pgprot_t pgprot, int force)
+static void __ref map_pages(unsigned long start_vaddr,
+			    unsigned long start_paddr, unsigned long size,
+			    pgprot_t pgprot, int force)
 {
 	pmd_t *pmd;
 	pte_t *pg_table;
@@ -449,7 +449,7 @@ void __init set_kernel_text_rw(int enabl
 	flush_tlb_all();
 }
 
-void __ref free_initmem(void)
+void free_initmem(void)
 {
 	unsigned long init_begin = (unsigned long)__init_begin;
 	unsigned long init_end = (unsigned long)__init_end;
@@ -463,7 +463,6 @@ void __ref free_initmem(void)
 	/* The init text pages are marked R-X.  We have to
 	 * flush the icache and mark them RW-
 	 *
-	 * This is tricky, because map_pages is in the init section.
 	 * Do a dummy remap of the data section first (the data
 	 * section is already PAGE_KERNEL) to pull in the TLB entries
 	 * for map_kernel */


