Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C0FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 04:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349424AbiDOEej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 00:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiDOEei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:34:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699AB237CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C4/aXgT2rxXdzbmb0Fcuq10vOEP710HS33AdSKpbY1U=; b=I2M9iF7YJqgQsIkghlIkMzpaPM
        Yh7DXkMkaVSGGBIR4mXRpuI1vR35rVNlffpPwenv7Q2TbjAHYp0I0iYgvmDz83W04YV1/B5vIKZMY
        8VSXZfUnQ+MxA2ElaaFneHslOcjZKmSos50P34plkXQt0626DC//sJJsi8YAugbrecUavlUExYfXw
        iOQdolcONO/oaZlGUHCIuoxrsnh2u0nVErMqSaSvmTh5GYdx+26YViZMgHHvJ9MrfQqKKSFEBvQFv
        uUqojJnN2s34I4j/XNpt5bWqY4ax6OOTU5Z+JJx+Kk8CAN5rZXKG+0TBVS3tJGfxkbxVfLmNldQoe
        XLnOWubg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfDcg-00FoxR-2W; Fri, 15 Apr 2022 04:31:54 +0000
Date:   Fri, 15 Apr 2022 05:31:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Li Wang <liwang@redhat.com>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
Subject: Re: testing/radix-tree: undefined reference to `kmem_cache_alloc_lru'
Message-ID: <Ylj1OvvCBeCGokfA@casper.infradead.org>
References: <CA+QYu4oi-Lmfj1uh0f-JE0WRmmyjtU94xP8OpbLxAGjPkm69Ew@mail.gmail.com>
 <CAEemH2cQ2NrjS_3FoCKpOV8faF59WcJU+jZ0sJEHC0yXgxfYCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2cQ2NrjS_3FoCKpOV8faF59WcJU+jZ0sJEHC0yXgxfYCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:19:29PM +0800, Li Wang wrote:
> Cc'ing Matthew and Muchun for being aware of this.
> 
> Seems we have to port the new kmem_cache_alloc_lru() function into
> tools/testing/radix-tree/linux.c as well.

I have that fix, just haven't sent it to Linus yet.
