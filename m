Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A16C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 16:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbiBRQT6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 11:19:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbiBRQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:18:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833592B68DA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:18:14 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w1so7537689plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SYrlIQNM11+pCl67EKGFAUuifDjJcq2DARoCN9iXbuE=;
        b=A5Ejl7kwnRRVkydPj2xWA01Tt6VhV1cpYau0skJ2g6Sn2jEmAqq4F0z3rTzgoQy80q
         QfWmJmrPYzQQM8BiHiW4zcIQqQwC+78EU2lBKvh8R1MT0nJ1SsEhiO5NRDUeYqkW4DcF
         5+U1iOfBhCvAwW/reG8mjr0udG8zjYEagW8jrEdSbR53LClZBpXBtS0eJzsoU3NCcbWP
         s2uigq5QKRPwAK/BzDjbjDJXOf6UjtSb0xLyihQeK7kZxy3FE9EGMmxSS+/JmiOkg/jC
         tCMLNzKLvmMRGbBXYYRw1LDUy18iVwUmWQ5wkdyKnlFYelbPYBQnHqKXmnXpt3scc+oo
         zcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SYrlIQNM11+pCl67EKGFAUuifDjJcq2DARoCN9iXbuE=;
        b=E7ILPIho8nrt/cNA3Arx1eEgKsVheGaRhmrd01btnLynnV/lKe9/Ds6Es+o0ZpU+7+
         0JzBvtciGJmUThi8vYfJRkQLlKuOfJq9D127/AUzHptestZ/khN3ctWuQMnRi+Hr5wqw
         zUacEjr1yAFRjFdFD4+GKkdk54x8gd9oCV93/F6Yobb/wkrjqUAQet7uSykuwv37q30A
         7zKx/fGdcBL3T9/ESUUcEOdG9iZUvq//OnUmo1mvgi0/tGE0s2LMxfrWdyokqdZDbaT1
         gE5eJjz48RD+FDFC7+rm60CMHI5qSLRyXNjK33g35aLHHMRRVJJe8GmAegqzjMQG6wlQ
         r5Fg==
X-Gm-Message-State: AOAM533V0CNDZt4dJ6rD5gc3PJo8bOQeKrJTLqeSsERyMHoK4XeHIcx1
        Rh0Gw3SDG44T4nbhX8Yzk47KkQ==
X-Google-Smtp-Source: ABdhPJzXyl03cf5rEFh0M6FROAOUQJOrXrLuRFPADLS+McwoSbmT8uc8CtrmVn9LHtqKl4/jLXS1Yw==
X-Received: by 2002:a17:90a:7d09:b0:1b8:da11:f70e with SMTP id g9-20020a17090a7d0900b001b8da11f70emr9237761pjl.42.1645201093640;
        Fri, 18 Feb 2022 08:18:13 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id ip10sm5618260pjb.11.2022.02.18.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:18:12 -0800 (PST)
Date:   Fri, 18 Feb 2022 16:18:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] KVM: x86: warn on incorrectly NULL members of
 kvm_x86_ops
Message-ID: <Yg/GwYbzrJ7Khrlq@google.com>
References: <20220217180831.288210-1-pbonzini@redhat.com>
 <20220217180831.288210-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217180831.288210-5-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022, Paolo Bonzini wrote:
> Use the newly corrected KVM_X86_OP annotations to warn about possible
> NULL pointer dereferences as soon as the vendor module is loaded.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
