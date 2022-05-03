Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4915C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 17:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiECRe5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 13:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiECRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40D971CB3E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651599077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TScWbWXEVWKnRBFQAFHlKCvx6D9GWzgwwEuiYtBAwlw=;
        b=K7oX0wGzL0VjHlb4lqwowK6jqwNdkO/xT4bFet28wS0lwQ0zxSRvJTOm58qQ8I/U6+pTbU
        XNcFPsr7edNZ14m6Kovd9wI5YsNfOQO9eie4A6N5r2+ozsorbAseBDthcAWk+k019LVFLU
        TC7Z7a3RLRdLzknv4VnOrLvfQS6dta0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-Lw6Z4Ct0N0KfauNV_MUxXw-1; Tue, 03 May 2022 13:31:06 -0400
X-MC-Unique: Lw6Z4Ct0N0KfauNV_MUxXw-1
Received: by mail-qv1-f71.google.com with SMTP id g10-20020a0562141cca00b00456332167ffso13757857qvd.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TScWbWXEVWKnRBFQAFHlKCvx6D9GWzgwwEuiYtBAwlw=;
        b=0R/YHqWFlF4AH1pJhr+SZQxUMRB2QBpjmOVAQTzRVvy+3oNtmEL1Hj6+cjAMruSrzV
         a43uj/yAz6f5alIkT68Gp8lDb6XILCYXPKAuONaVc9ARZ4odxHGKFgHS1AlXv5GNFHa6
         dBt5SEN3Gz0Ni87VE086WHkxNgDEevgNbMi76pXJv1h3g3wQlSYAqaRA7Z9+jCz0NqNf
         tlLtQ8CNwcO+K2MakMgTdlaZlPo1Y2u0EzuDzOh6SAjI124xzroMkTRnId/jJ2NfW8u5
         c3gW4oBOsrGDUus0kQqk0MAl3qeTKA1atabpf/uRjFOlZqPkxLLhT9tU5vlgZ+2Q5ADR
         0/7g==
X-Gm-Message-State: AOAM530kol4xxKELaiqiSPatFUjgzGxyYYCv5weQzdiKkJV7JpQtaK3T
        w1Z/pcsxRtHpluJdzpwo19Rcr+VC1HoiAbLs7gGvEWWH1Auk77O/3VAoGnMYMLl8Q0zeof+j6QU
        rCD4TvmbPlA4qC6IybYvoQj89
X-Received: by 2002:a05:622a:309:b0:2f3:7d75:8409 with SMTP id q9-20020a05622a030900b002f37d758409mr15587840qtw.485.1651599050646;
        Tue, 03 May 2022 10:30:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjXJ6WRKqUWq4aJyRjPRGX9HKH3Wk5dPulo0BzJo+htkxjC4tIchweNZkYHPts6wI7BFCeNQ==
X-Received: by 2002:a05:622a:309:b0:2f3:7d75:8409 with SMTP id q9-20020a05622a030900b002f37d758409mr15587816qtw.485.1651599050430;
        Tue, 03 May 2022 10:30:50 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id y144-20020a376496000000b0069fc13ce1efsm6104766qkb.32.2022.05.03.10.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:30:49 -0700 (PDT)
Date:   Tue, 3 May 2022 10:30:46 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Seth Forshee <sforshee@digitalocean.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] entry/kvm: Make vCPU tasks exit to userspace when a
 livepatch is pending
Message-ID: <20220503173046.fv2aluc34bxhzgq3@treble>
References: <20220503125729.2556498-1-sforshee@digitalocean.com>
 <YnE5kTeGmzKkDTWx@google.com>
 <YnFVugyU8+XBVRqL@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnFVugyU8+XBVRqL@do-x1extreme>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 11:18:02AM -0500, Seth Forshee wrote:
> > Can the changelog and comment use terminology other than migration?  Maybe "transition"?
> > That seems to be prevelant through the livepatch code and docs.  There are already
> > too many meanings for "migration" in KVM, e.g. live migration, page migration, task/vCPU
> > migration, etc...
> 
> "Transition" is used a lot, but afaict it refers to the overall state of
> the livepatch. "Migrate" is used a lot less, but it always seems to
> refer to patching a single task, which is why I used that term. But I
> can see the opportunity for confusion, so I'll reword it.

The livepatch code does seem to be guilty of using both terms
interchangeably.  I agree "transition" is preferable.

-- 
Josh

