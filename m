Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 15:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiCLPdA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 10:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiCLPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:33:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB34F192580
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zLkTAwyDVD9LSFsK+1dSCDDfPpQMrdtPI8MjxNSKzSU=; b=k6ETk9TvLDn0yESmpoVClkqUxM
        sFFQ9V2LjgoR0IipB/oVnKuUqHBNipd0yOwlwRmVLw3Bly3WQ12C4/b3MGzM/piMCxZU6BJudekTx
        nHDaG0Rstru0Oek8DkH4fsFGeoGfvOB94AONx4+VlaeCmmPzQEkyHuxj/L4kHLrh0D86IQOkP7hr7
        HVPQTUOiSv3aU5z/nMo9j1kW/zwZeTGJJpEkEWxsd0E80kMXrXr5/RuuYcQihb2XRf1vr3vI1jCEQ
        FCkJbLZ1HSJo3XnDm2ywZKf7PKdwXy+dmRZY/TrlYTSOoGpPni10wc+n3y2wqH3zo3thesaHIkbPX
        KeiA+79A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT3iR-000Cxp-Nt; Sat, 12 Mar 2022 15:31:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF7CF987D0D; Sat, 12 Mar 2022 16:31:33 +0100 (CET)
Date:   Sat, 12 Mar 2022 16:31:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/alternative: make .altinstr_replacement section
 non-executable
Message-ID: <20220312153133.GE28057@worktop.programming.kicks-ass.net>
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <20220311144312.88466-4-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311144312.88466-4-adobriyan@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 05:43:11PM +0300, Alexey Dobriyan wrote:
> Instructions in .altinstr_replacement section aren't meant to be
> executed by CPU directly, only after being copied to the real
> instruction stream in .text/.init_text.

But who cares; the entire section is deleted right along with
.init_text.
