Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E10C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 21:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiGEVUG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGEVUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:20:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B214037
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E894FB8199F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A2C341C7;
        Tue,  5 Jul 2022 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657056001;
        bh=GuMN04dM0yPy/T7mcoypjTe3KAFdKDQ5GLqvAJa+Hn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bLd4UNH9Hv6qP6cPuZH1KeLmWgLGqLsg9YNVjQrobGOajvvvCimp58tSwzK0ZGbO4
         6+7d7cE5vxvBsIZF63YxJL0SE0tJk7GUNJOVTkBUYXvUkhfwjRyATyVje3zi83ZyXi
         nfTyVsPEXdlbk6plXBgExryQgBmCacImhFRh5Jyw=
Date:   Tue, 5 Jul 2022 14:20:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: percpu: use kmemleak_ignore_phys() instead of
 kmemleak_free()
Message-Id: <20220705142000.4679acaaf1238a73a555ea58@linux-foundation.org>
In-Reply-To: <20220705113158.127600-1-patrick.wang.shcn@gmail.com>
References: <20220705113158.127600-1-patrick.wang.shcn@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Jul 2022 19:31:58 +0800 Patrick Wang <patrick.wang.shcn@gmail.com> wrote:

> Kmemleak recently added a rbtree to store the objects
> allocted with physical address. Those objects can't be
> freed with kmemleak_free(). Use kmemleak_ignore_phys()
> instead of kmemleak_free() for those objects.

Thanks.  What are the user-visible runtime effects of this?

And are we able to identify a commit for the Fixes: line?

