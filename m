Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721CAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 01:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiBVBJC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 20:09:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiBVBJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:09:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDD24580;
        Mon, 21 Feb 2022 17:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BD7861470;
        Tue, 22 Feb 2022 01:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A31C340E9;
        Tue, 22 Feb 2022 01:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645492114;
        bh=v5L0ved1NKG+ZTYnRrZeZ442lStuTXMdW6mlOtSkurQ=;
        h=From:To:Cc:Subject:Date:From;
        b=AKNrz0zFvrPoLQGlQopakjVSk7C++LFTmmLqXO4LUVVDg/RlrppdnRoyxiZtJnt7l
         FmP8TL43dxtghbXpwNF7RgVBBqklAc9fn2OXolblECPDqc6RA9XFtXsBqRJRsMZ3v2
         Pl1TyLNrK3xoCSeFAb0SsjZloSBug+UxP85esL2aI4GoXEwutQnao2x+/Fm2ZLu7e4
         hD7rCGYpuk1ZOBEZPhJ7QSZdKGEcBeEpB5plJ+7jSGzYfXNpI+4gtZzxXnIZFX6Fzg
         JX6Ev+dOZTLrK61be8JEhQcA6yeMvpZqZ/ho5XKBli37TVvDE8Q2eVOfp1e7NAP17u
         4rUaIzh33pbtA==
From:   broonie@kernel.org
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: manual merge of the slab tree with the origin tree
Date:   Tue, 22 Feb 2022 01:08:24 +0000
Message-Id: <20220222010824.3406817-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/slab.h

between commit:

  07f910f9b7295 ("mm: Remove slab from struct page")
  d122019bf061c ("mm: Split slab into its own type")
  4b5f8d9a895ad ("mm/memcg: Convert slab objcgs from struct page to struct slab")

from the origin tree and commit:

  b9059d7a5face ("mm: Split slab into its own type")
  90fbf2f30c38f ("mm/memcg: Convert slab objcgs from struct page to struct slab")

from the slab tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

[I took the origin versions]
