Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516BAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 17:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350697AbiCORpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiCORpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:45:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFA4EA11;
        Tue, 15 Mar 2022 10:44:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22FHi06n003092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 13:44:01 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7F0C315C3E98; Tue, 15 Mar 2022 13:44:00 -0400 (EDT)
Date:   Tue, 15 Mar 2022 13:44:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the folio tree with the ext4 tree
Message-ID: <YjDQYKIPaeOEd+7e@mit.edu>
References: <20220315204007.05ad4817@canb.auug.org.au>
 <20220315112512.yl7dewzglimjurh5@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315112512.yl7dewzglimjurh5@quack3.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:25:12PM +0100, Jan Kara wrote:
> Thanks for the notice Stephen! The resolution should be like:
> 
> - 	WARN_ON_ONCE(!page_has_buffers(page));
> + 	WARN_ON_ONCE(!folio_buffers(folio));
> 
> How are we going to handle this conflict Ted? Just tell Linus about the
> conflict and resolution?

Agreed, I think that's the simplest approach.

					- Ted
