Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A65C19F2D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 21:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiHIVjD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 17:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiHIVi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:38:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F426AA09
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:38:58 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9800329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D96B1EC058B;
        Tue,  9 Aug 2022 23:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660081133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z7EqNC2JC1LQyjie6IGXTeUlMukP0way+PG3jpA030g=;
        b=HuASkridB9JKtbKczbJ6+nZQnXupD01ZyV3+uZ4NHXJimPmKjB5KVXpUQDXOl4noh1iab+
        EshmxEmARNQf/WN7BVm329ZQNSTKWXIqeLG0aX/xJ7jACViZiP2iM9wXdjOBngLmQR6h3H
        AbGepgLX+EBUJ9ca92ULDdF1Dr7KDwQ=
Date:   Tue, 9 Aug 2022 23:38:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ira Weiny <ira.weiny@intel.com>, Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
Message-ID: <YvLT6FipPdSkCW/6@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-3-ira.weiny@intel.com>
 <YvJNe2rzXfcogFFX@zn.tnic>
 <YvKpi/CVHko50PNQ@iweiny-desk3>
 <YvKsS3QuOu4JVzZU@zn.tnic>
 <87lerxqfv8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lerxqfv8.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 11:14:19PM +0200, Thomas Gleixner wrote:
> Ira is right. If we want it for everything, then the generic code is the
> right place.

But what is "everything"? Currently, and AFAIU, it is for the PKS use
case on x86 only.

I'm not saying it should not be done this way eventually - all I'm
saying is we should not design "preemptively" before it is really needed
for other arches.

Unless putting it in generic code makes it all simpler and cleaner to
do, that is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
