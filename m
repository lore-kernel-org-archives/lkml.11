Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB315C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 17:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiCRRla (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiCRRl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:41:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C95196084
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cya1qLD0P42aWQWkjKaY3QBjbUjBXUzgtuTZm/iNADQ=; b=VYpN1CoBXGW19Y0/LzJfcfuerc
        3eIeWuR++TJKWvOxX1KDba3UudDsT+Lr5buXNGmiQdlHdLMy/JU6q5+xYYx5srDlzTPkQiwnxHbde
        S0bueT3j0CFJTgUGZnRiS5OLqV0LM3ro7zIV6g7Zqaa56e1zio+KIDc+62zFZYiR08VR0/YLlfMLw
        /VPSTpc4xe8zlLuCptrq162W5jdbQdrfF+qb7pwaqSsLhwRSS/hRfirhXiJUCqKsGl4BDFDGXmqHW
        anCypu1Y4iiXNBQavBxPuLcTtzuA6f5AOnLWvjxswQxc6Kd/Ep5Bu98mFt18A/KnBJrBWqfdYe8W1
        VGiYLfqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVGZX-0089Iz-4V; Fri, 18 Mar 2022 17:39:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE52598841D; Fri, 18 Mar 2022 18:39:30 +0100 (CET)
Date:   Fri, 18 Mar 2022 18:39:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v1 1/2] static_call: Properly initialise
 DEFINE_STATIC_CALL_RET0()
Message-ID: <20220318173930.GR8939@worktop.programming.kicks-ass.net>
References: <1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8.1647253456.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8.1647253456.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks!
