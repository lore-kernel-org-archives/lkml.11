Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD86BC3525A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jan 2022 02:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiAZC0K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jan 2022 21:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiAZCZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:25:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2E6C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89988B81B99
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB22BC340E0;
        Wed, 26 Jan 2022 02:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643163953;
        bh=2i0dNkIQ1hr+oqd2smUFvkRp5ceQ2EOEXTxyE8SD98w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LAVawXj58Da+S7DVBP36hp/PLlCVDcV8Apz3X9OFevT1KnTmaaqT9GgeMfKG4T/AG
         Y9fFKZqq25/qfZMAoBYgqxjufcf0LEE9P9MzLJRaXiVQBhtHnNcrBs3tnCzM8ls1zB
         BqTOKkluSFu5a9meFnLDOy9Q76kHSdrxp8p8SKD0=
Date:   Tue, 25 Jan 2022 18:25:50 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] vmap(): don't allow invalid pages
Message-Id: <20220125182550.7c693c76fe6520047c2e4f26@linux-foundation.org>
In-Reply-To: <20220119012109.551931-1-yury.norov@gmail.com>
References: <20220119012109.551931-1-yury.norov@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 17:21:09 -0800 Yury Norov <yury.norov@gmail.com> wrote:

> vmap() takes struct page *pages as one of arguments, and user may provide
> an invalid pointer which would lead to data abort at address translation
> later.

Does "user" mean userspace code?

If so, please tell us much more about the means by which userspace can
trigger this problem.

