Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257C9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 00:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbiBKA1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 19:27:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345570AbiBKA1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:27:38 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB255A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:27:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p6so3110260plf.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87vVVlt1Gj8gtKfe5Lr2/twqlYXCww3QQq8NSJlRxOY=;
        b=g6faqlPYdt6/QRXXz+XK476VGGGfTiJy3bKL70N0F+WD8GrL4lZc+StV90vlUD3Nm4
         W0WE6qNKicd2LtJjrPifzDGgb1ONl2cgs7eY0MEoZQ65zsVV5LsiiKDDDDJpzwRgeAQg
         syxBykrBibhV/yk/P7fGUObXiFfiICbaDF8awb8nT++oCUI1u7qxVNQuGV8LCndsLJwW
         sMFVwlqYEJH/gntTENi/GnHlDxMm6LGhaeH7NLF83CUzQH6UH0u+IyLCCPEtgzVL2UIg
         WhcqEsBAXsgRMKLIqat4nfklmIdWaHd7UltnlJAqSi4fX8L6LnbYFa86sKy+qS7LBeFP
         EIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87vVVlt1Gj8gtKfe5Lr2/twqlYXCww3QQq8NSJlRxOY=;
        b=u5spaFSneQ3Z379hQQwDm2oqTwbFolBaNcN94PYrqZ4I+ux3P7ytljNmN3n1l0EP3d
         o0tm9YOqimOLhF/BwAafzAvU06gxxHhhj4rH+7WaKRl/d7vzlPtnHrWBY3XYoU2Gmoq/
         gaLTSdZkyzo5NexAmUcQxhvpAlh+O1XCnJ4iRDhAMilUmsL8DDkOhbsi4NBboHdZDinG
         dCmzj8+060YxjgFtGLha3ENwebfx0/xLkxjcpg5+S9Z/dRbcpQJwDYnXIIdBdgvuiCGG
         x7RdXF3tQkZ+ZLCzqx3w6cmd0CcUNeJ3M5d1p3Gago/8aX0Wjxq9dcQB5xRI8SWePfcO
         slWw==
X-Gm-Message-State: AOAM532N4tmZDBgFAlKpaD41PXlidlHQE0Yn6SO3yrOVgj+BvI23uMez
        jL/v2RPA121vk7xxgKD7Gfs2WPOZ+C6DMw==
X-Google-Smtp-Source: ABdhPJzTy01qWyWwog/7undC3RcQ3tQ8v0n1XiIFjQWriUIblT6wduEMltC5zYBM6SDbmqX8rigDaw==
X-Received: by 2002:a17:902:eb8f:: with SMTP id q15mr5303584plg.67.1644539257851;
        Thu, 10 Feb 2022 16:27:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t15sm18290964pgc.49.2022.02.10.16.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:27:37 -0800 (PST)
Date:   Fri, 11 Feb 2022 00:27:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
Subject: Re: [PATCH 06/12] KVM: MMU: rename kvm_mmu_reload
Message-ID: <YgWtdUotsoBOOtXz@google.com>
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209170020.1775368-7-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022, Paolo Bonzini wrote:
> The name of kvm_mmu_reload is very confusing for two reasons:
> first, KVM_REQ_MMU_RELOAD actually does not call it; second,
> it only does anything if there is no valid root.
> 
> Rename it to kvm_mmu_ensure_valid_root, which matches the actual
> behavior better.

100% agree that kvm_mmu_reload() is a terrible name, but kvm_mmu_ensure_valid_root()
isn't much better, e.g. it sounds like a sanity check and nothing more.

Maybe just be very literalal?

  kvm_mmu_load_if_necessary()
  kvm_mmu_load_if_invalid()

Or follow cond_sched()?

  kvm_mmu_cond_load()
