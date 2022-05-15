Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC17C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 11:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiEOLhg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEOLhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 07:37:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288583B028
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 04:37:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652614649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qALbpys+3AHBZg0ZIcIY92DAu5RuDTntt3Mqy3t4PlE=;
        b=3X47OqRBuFJVxcmxA3as/j98DDZU39LxVtZksep/ofDSgR8XvFi+f9YHYuB93BKsNf/STE
        BbVUPc3sMJeVwwZeFUiNxwH7gREAg0DFCB3ZVclIndMOf3YlLU+9VgzrY/phmT4vKqKojY
        2AelW7ys+0EWOx50jURWLabzgpMHPUL0J9x9Sc9ONPjGscZAnItPhSEdkkUngFZLS0+iVs
        JVc+aX72C62OIKnMDwTtvUYa5/bUiSv+kIJJzmcwZOgXlFLs+Dm+Re+Pl2cN7oEH30upNz
        po1Aa5jwTbnTM22f26BwuTV/byG+uhMIDjwBjzsQCkWX95r8tYQng/4jJ7vb1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652614649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qALbpys+3AHBZg0ZIcIY92DAu5RuDTntt3Mqy3t4PlE=;
        b=zVtd3PEwlrPkzSYBQwfQxOE00NLApylBZmpKoef4D5YYXGWZ0s4VR5os1Xjyse5R4vs8uk
        nXdYT9SJ1+wLH/CQ==
To:     Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/nmi: Make register_nmi_handler() more robust
In-Reply-To: <87zgjlsn75.ffs@tglx>
References: <20220511234332.3654455-1-seanjc@google.com> <87zgjlsn75.ffs@tglx>
Date:   Sun, 15 May 2022 13:37:29 +0200
Message-ID: <87wnenqb5y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13 2022 at 13:10, Thomas Gleixner wrote:
> @@ -157,7 +157,7 @@ int __register_nmi_handler(unsigned int
>  	struct nmi_desc *desc = nmi_to_desc(type);
>  	unsigned long flags;
>  
> -	if (!action->handler)
> +	if (WARN_ON_ONCE(action->handler || !list_empty(&action->list)))

Bah. That should obviously be !action->handler. Let me send V2

