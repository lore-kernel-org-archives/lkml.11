Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E484FC04AA5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 00:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiHYAPK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiHYAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:15:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C5642DD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:15:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id io24so3804036plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=n+ySj59iuhXBdH7RwhR2A/p3y2hpdOt74I5f5GJbaSQ=;
        b=QF/70eGuJb/+uVaUM/C1aTb4BKXUu8qGyIWbycD3aNYqZVoYgui+EaP1SK14zpiLmM
         MVlYHYvRaEf69gvlUZ+Nm96rL5vChHjU7ul3wBflss7VGE58g0hsTnzdpxrF6rmDk+PW
         zrzxEvVVHUX8AJpyWF1WQA+4FIHevPQecQNYjRxbdT0u3ClM/IpXsDHTcSae4mdTBCnX
         4TMhqgI6wzURR46zugKlk4K3hpu6AWPtclYZnnme7yilUEPb5xSIg5Jo+AI+WyH41VyO
         z0t4HY94631pjfPV16IioFxfecbZwDDvhU6TiYgYrLSzZlXm703V53r9TN4fB2SExUnd
         X9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=n+ySj59iuhXBdH7RwhR2A/p3y2hpdOt74I5f5GJbaSQ=;
        b=S3yv7eoymRq5EJm851ip7N8XMk3YHpRNwmDIBcDrwyy8qLnO6AnEDAdWE76BR9A/Zc
         1FEkGHyGgA4GFeQlKZe/Dx2TeVHx+q6VRCyaWKR5clfOh+RQsw9/DTyge3s2lawROHwM
         dDrgXMns/X8Pd/oCVvB1eVR/txAAspfiWBIWUCQVivaLc8B/FJAe17wB88UG5yXtROuJ
         8sZ19YvIqPOSyonTHv4Okv9YXOJeYlUV1ZscAJ72pfXoWL2Nw2awbwzLT9f3lXoxFrO5
         lf6zDsW+qLYciBZFSTloYswOFXzjSdfvLAoZw4X6oXwk1Gon8ACcRiA2vzv89/Gzt/Jn
         YUIQ==
X-Gm-Message-State: ACgBeo3qJPqtDziimDZXlmQ8H2mchNyw0gObq90z5EovwYyymnF71jty
        ScjaXjkAkM8mJk0ZJNA/gIjgYg==
X-Google-Smtp-Source: AA6agR4J8b4pMIkDlsiPr/WCKybp/istJCAy5D2HjF5oCz7I/g5txBHuvEBaB1b4xOcgMRPirjrw+g==
X-Received: by 2002:a17:90b:918:b0:1fa:ad32:57f3 with SMTP id bo24-20020a17090b091800b001faad3257f3mr1719911pjb.28.1661386505798;
        Wed, 24 Aug 2022 17:15:05 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w185-20020a6230c2000000b0052ac12e7596sm13540564pfw.114.2022.08.24.17.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 17:15:05 -0700 (PDT)
Date:   Thu, 25 Aug 2022 00:15:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 3/5] selftests: KVM: Introduce vcpu_run_interruptable()
Message-ID: <Ywa/BaYIdBi7N0iR@google.com>
References: <20220802230718.1891356-1-mizhang@google.com>
 <20220802230718.1891356-4-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802230718.1891356-4-mizhang@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022, Mingwei Zhang wrote:
> Introduce vcpu_run_interruptable() to allow selftests execute their own
> code when a vcpu is kicked out of KVM_RUN on receiving a POSIX signal.

But that's what __vcpu_run() is for.  Clearing "immediate_exit" after KVM_RUN does
not scream "interruptible" to me.

There's only one user after this series, just clear vcpu->run->immediate_exit
manually in that test (a comment on _why_ it's cleared would be helpful).

> +int vcpu_run_interruptable(struct kvm_vcpu *vcpu)
> +{
> +	int rc;
> +
> +	rc = __vcpu_run(vcpu);
> +
> +	vcpu->run->immediate_exit = 0;
> +
> +	return rc;
> +}
> +
>  int _vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  	int rc;
> -- 
> 2.37.1.455.g008518b4e5-goog
> 
