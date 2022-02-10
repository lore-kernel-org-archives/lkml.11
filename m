Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D64C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 17:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiBJRaB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:30:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBJR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:29:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8221BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:29:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n23so11511256pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y9MnmD2bSwsnvEnxXgt0owCbJFsLwnmCwLpJpglBXOY=;
        b=JXSIoN/RuFEMa1gcezB38jipRmkjUWzNsXKP94nzIGpES6fsmKdDAeD1Wttcv/S+W3
         Ut84mGPhxjkc+48GxecL4LdG4emEhZX4vQbpW+rIhpVgz6qXystRCVDWIzFYAKy2ob1p
         C7OkP9+GSM9TNuzj2Jk6QGpxvYGawAg0OrP0nAEM4Dqpbqv0vHAZEa3u+w3Psizl5eeo
         oqRiTebEjZCqBwHPNINj9fJ9mDVacJGk6OYaYcYwnPyxNrXkDUPMtAjDNTTOflPLKbtq
         wvwXjc3NY6pbrKialisoAypt+6VaGJ8AkAJJmdMBWsFv53zg2DnZc5tm4sPO2obSnX9i
         ce3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9MnmD2bSwsnvEnxXgt0owCbJFsLwnmCwLpJpglBXOY=;
        b=wx9V483w56k6iLc0vfqm720Xp8Cehx5mNjJ8rGXjHr2hhkp2zj6M3hH78XiNDZX0Bz
         gvgTBcCwPSU+8Gw8oS4CsTogEBst92PN4YXwTjH6D/s+PYMqOYDFHnOT4YWZmH9k56JS
         0UnopO2/PnqZajUAeeZliCg/63XdPlNicqDF1A0GzUQEA1VY0BG3MXezzyi/CvxoDx9W
         0rJ75zc7ue+AX/1q8JClanBhHRelehv9aoEmnju/V60Pn9Tnk7v0d5alOwS9A5H/qk8c
         rMVz7zTuSHzMD10IPKBYqN+WhWhsRZsbARcsBxr6yULar1TqIFTa683AGPmTsSOyuwxl
         XnCw==
X-Gm-Message-State: AOAM532HKRvqpqZWgcwvKqbexp8+PyyqxjLYr9VSTU9OFk0QbG97lDOP
        9lA92dypJu/3PukmDNXh5eYIaQ==
X-Google-Smtp-Source: ABdhPJz9a+GpGCnNOhpvPCTUn/KBUvTg0rSn1KqekTtgz6jYeT0nzgRu5MU56sM1UTZ68gAQAtL2fw==
X-Received: by 2002:a05:6a00:198f:: with SMTP id d15mr8595561pfl.78.1644514198738;
        Thu, 10 Feb 2022 09:29:58 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j3sm17890957pgs.0.2022.02.10.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:29:57 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:29:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com, vkuznets@redhat.com
Subject: Re: [PATCH 07/23] KVM: MMU: remove kvm_mmu_calc_root_page_role
Message-ID: <YgVLkgwBRy+JXZiH@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-8-pbonzini@redhat.com>
 <YgRgrCxLM0Ctfwrj@google.com>
 <1e8c38eb-d66a-60e7-9432-eb70e7ec1dd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e8c38eb-d66a-60e7-9432-eb70e7ec1dd4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022, Paolo Bonzini wrote:
> On 2/10/22 01:47, Sean Christopherson wrote:
> > The nested mess is likely easily solved, I don't see any obvious issue with swapping
> > the order.  But I still don't love the subtlety.  I do like shaving cycles, just
> > not the subtlety...
> 
> Not so easily, but it's doable and it's essentially what I did in the other
> series (the one that reworks the root cache).

Sounds like I should reveiw that series first?
