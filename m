Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A40C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jan 2022 23:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiAGXvQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jan 2022 18:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiAGXvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:51:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF8C061574;
        Fri,  7 Jan 2022 15:51:15 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC92862051;
        Fri,  7 Jan 2022 23:51:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3389660F3A;
        Fri,  7 Jan 2022 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1641599474;
        bh=yOsOeSv/wlGNjga0fJsyxc4HfwJ06Uk8e97pXTHHLz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bskey3cL0BDMSe/u+YyciKNQaeNVEqTwnc05Ydqm4s81X2vhOIGTUi9IUPn4mXtVD
         4dK7N05SG+Wa1JhTinJAMQXRi7mInMoKte1SlYmESBpX9QQrQFrM8O0M6XEuzbTo4f
         ALyyUi/IoTrlARIFT/c1863ZDORJLeO/etb2NuW0=
Date:   Fri, 7 Jan 2022 15:51:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] usercopy: Do not fail on memory from former init
 sections
Message-Id: <20220107155112.30671fe4bb53ea71029f5a6d@linux-foundation.org>
In-Reply-To: <YdeHDDAP+TY5wNeT@ls3530>
References: <YdeHDDAP+TY5wNeT@ls3530>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 01:19:24 +0100 Helge Deller <deller@gmx.de> wrote:

> On some platforms the memory area between the _stext and the _etext
> symbols includes the init sections (parisc and csky). If the init
> sections are freed after bootup, the kernel may reuse this memory.
> 
> In one test the usercopy checks if the given address is inside the .text
> section (from _stext to _etext), and it wrongly fails on the mentioned
> platforms if the memory is from the former init section.
> 
> Fix this failure by first checking against the init sections before
> checking against the _stext/_etext section.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 98400ad75e95 ("parisc: Fix backtrace to always include init funtion names")

Wait.  98400ad75e95 is actually called

	Revert "parisc: Fix backtrace to always include init funtion names"

and it reverts 279917e27edc2.  This isn't making a lot of sense.


And neither 98400ad75e95 nor 279917e27edc2 touch csky.

And I really wouldn't want to jam a patch into mm/usercopy.c at this
point in the life of 5.16 anyway.

I'll drop this patch.  Please revisit and clarify all these things.  A lot!
