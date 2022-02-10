Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B3CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 23:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbiBJXAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 18:00:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbiBJXAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:00:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4A1105
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:00:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y7so3175301plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KEDi7BzApy9NyPhE3GwFUFpSbJpaoj+MohuY7q6ukn8=;
        b=rC0MuFpLCGX/wILsiUuPi3U1gQg31caG4BiNWRkZyARysxxOUUv8Q3LNzjO+P+Nk4y
         2r9JQXfBsPd5Ndy5bfdBm1UQStmdMFkUSa9ZuGJ2Jbx0vAGuMzkjBl0HVJzFfBHPzqRM
         oZ/+2fopYX4+xZ4Xtf3ezO+u9pX9x2tJREvwE9mVekhs4fzaFfwcbbR6EsMgKcKm92Ly
         1v5axtqmVRVRJoeblg4A+0nGSHgduY0/yBdo0gSsD1+AMMCbwQJzPItE4B27jVFD+YiP
         khM8cU5635c5J+kXgZcI4na3T/UF9GRUHOmBq0MRvWfUXPam2Lf/Sjy+0aMjN2GYOj3v
         L6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KEDi7BzApy9NyPhE3GwFUFpSbJpaoj+MohuY7q6ukn8=;
        b=QdLh80nDwcFh2izqs5+Y1IQrxNQ0ouU00pyPyT+867cCAcit+DidJog2EYvHJn7Rdt
         Wa+nJuSAQupAn11GFxdGuRSQ3CZzIx2xnNYvgC+NCk/hFQugul4DtalWrZWgdmsP8bnR
         ilHxFh6EUPVygLTFPvkaHTCFGaJOp12/cqBVwNsOloMj0LBYeHXjCgtbk1eqMCB+JSc+
         bc6AJWxsyH57Bvfi08IL7xDBraFB8ZfXw1bgzadNepmlhxsp2rHQoWX94UGIesNhTXFy
         o2AJvs/IR49QU/2XFHgXD5A90vBEAjVfjau9pL46Yv4hLepQPJ5GKlPaDKbFh03DOkck
         TFWQ==
X-Gm-Message-State: AOAM533lT86lQamJUwMDfoYmE3qQyTpGBUZyJKIpzHTgdlbAbHwPk8lc
        CXFZKccIysnuSxlmIJJyoRtzww==
X-Google-Smtp-Source: ABdhPJyn2Ky81FVl3Upy6x198Hz9a9Q7KTbh/uhEkowKvr9pyNxCLlAHzTTAPzh5pud+RCCDx1tcXg==
X-Received: by 2002:a17:90b:3c6:: with SMTP id go6mr5136781pjb.230.1644534045516;
        Thu, 10 Feb 2022 15:00:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q8sm26524792pfl.143.2022.02.10.15.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:00:44 -0800 (PST)
Date:   Thu, 10 Feb 2022 23:00:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
Subject: Re: [PATCH 02/12] KVM: MMU: move MMU role accessors to header
Message-ID: <YgWZGa9qNfc/GmA1@google.com>
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209170020.1775368-3-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022, Paolo Bonzini wrote:
> We will use is_cr0_pg to check whether a page fault can be delivered.

I strongly prefer we keep these MMU-only, the terse names were deemed safe
specifically because they are encapsulated in mmu.c.  The async #PF case can use
is_paging(vcpu).
