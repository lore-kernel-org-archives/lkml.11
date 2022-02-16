Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922D5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 19:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiBPTrU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:47:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiBPTrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:47:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7C1CA515
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:47:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C11C4CE2844
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BDDC004E1;
        Wed, 16 Feb 2022 19:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645040821;
        bh=O6A+dtwhJsUxbYzeWBeyoSFV8FBZ9gZbu1DG1ZCq9zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WKP2MV151mFAwGNB+Ml5hTfhWp3CzXvBcrhr4CK9BGNTnXZPfzek5aGRCFU1uSfbF
         80Zgb/85Ub4hd1ZTtVYGRmKa2BF8PUX2R6BOxg3h+EYCiY5vIMHUdA/OPN1hTrMmTb
         skZrbKhqG0Yd5WBGpUUK+J86cPggqsItAcTlUpTQ=
Date:   Wed, 16 Feb 2022 11:47:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-Id: <20220216114700.f9473d88144dc59fc4d764fb@linux-foundation.org>
In-Reply-To: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 14:37:44 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> The maple tree is an RCU-safe range based B-tree designed to use modern
> processor cache efficiently.  There are a number of places in the kernel
> that a non-overlapping range-based tree would be beneficial, especially
> one with a simple interface.  The first user that is covered in this
> patch set is the vm_area_struct, where three data structures are
> replaced by the maple tree: the augmented rbtree, the vma cache, and the
> linked list of VMAs in the mm_struct.  The long term goal is to reduce
> or remove the mmap_sem contention.

Has a path been chosen which gets us from here to significant reduction
in mmap_lock overhead?

If so, what's the plan and what must be done?

Thanks.
