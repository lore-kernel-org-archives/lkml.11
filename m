Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 09:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiEOJZU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiEOJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:25:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE02813F4B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:25:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652606709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SUxfBjeM7R1jgkM/zti1dxKT7f0QkoDx8P2YTs/aV7g=;
        b=LiB4G/q9YkhJ0W/VrVtZcAklUfl3VHwdjv3gSRaj7afgMqv/hX17xbVotw0QjJ37hwFLQy
        EnJ0E0QPMl+g+hZQGrHmR3YNgqtBOoI8sj0XEBtzMYAVTdnbgKPXC7AEyPjoZ6Vmdl+X3I
        iCxaFRV5RPeAT9ZykpEXStchC802jt6OrgI36ZfC3LPhJe85UftkRRqRiOBfKwtzLRbUgB
        lc3fVlYGgKhCLBbhmi9jyu50P+UE16hY9gK/6SEEPIO3E9LqtCMzv6GlE7lXruGrqwU4Yn
        Dddo3I/r1qLlUGD3LQseKkyRLyXBYdpV0TX9RCMQLMIHBaO/ckp+baT1Wgp9Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652606709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SUxfBjeM7R1jgkM/zti1dxKT7f0QkoDx8P2YTs/aV7g=;
        b=+t8IuuN3UX37AKn9yJAHy4pj0b4871XpSR6+e/t525ce3m9dGMvIVV0BnDS5HuP7v/9xwp
        SM+iRl5ypENf9XDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.18-rc7
References: <165260667543.920532.17932536291158599837.tglx@xen13>
Message-ID: <165260667833.920532.1890128975471695929.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 15 May 2022 11:25:08 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-=
05-15

up to:  280abe14b6e0: x86/mm: Fix marking of unused sub-pmd ranges


A single fix for the handling of unpopulated sub-pmd spaces. The copy &
pasta from the corresponding s390 code screwed up the address calculation
for marking the sub-pmd ranges via memset by omitting the ALIGN_DOWN() to
calculate the proper start address. It's a mystery why this code is not
generic and shared because there is nothing architecture specific in there,
but that's too intrusive for a backportable fix.

Thanks,

	tglx

------------------>
Adrian-Ken Rueegsegger (1):
      x86/mm: Fix marking of unused sub-pmd ranges


 arch/x86/mm/init_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 96d34ebb20a9..e2942335d143 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -902,6 +902,8 @@ static void __meminit vmemmap_use_sub_pmd(unsigned long s=
tart, unsigned long end
=20
 static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned =
long end)
 {
+	const unsigned long page =3D ALIGN_DOWN(start, PMD_SIZE);
+
 	vmemmap_flush_unused_pmd();
=20
 	/*
@@ -914,8 +916,7 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned lo=
ng start, unsigned long
 	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
 	 */
 	if (!IS_ALIGNED(start, PMD_SIZE))
-		memset((void *)start, PAGE_UNUSED,
-			start - ALIGN_DOWN(start, PMD_SIZE));
+		memset((void *)page, PAGE_UNUSED, start - page);
=20
 	/*
 	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of

