Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08954C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Mar 2022 14:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiCMOEw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Mar 2022 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiCMOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:04:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F219BAEE;
        Sun, 13 Mar 2022 07:03:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p9so19977128wra.12;
        Sun, 13 Mar 2022 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bsVlcHB3ec0VN84WfK2K0le9by2GbiEhUS8rbLlGQ7A=;
        b=lbXkMpykNCPZ7BL2+aNoLjQiqArrzNrMFVo40RDj4thfzAXnjIIb/eTYla3uVJUcWv
         ZSV9Z4ey1XAwPtbYnA4K4diErMZr7CbwwXJ0RcbYkZI7Bccw4oxoQ+UIvs+dHkpaRjGZ
         BzjBZBut16uQXwY79FtQykcDXZPx+eXvxkTfHBLqwAwYAE1h7EZ9I2E8ePb28vVC/Q57
         hJ+Bsw4HXHneg0yf+hRKTfGjopW5t1QB/awA+axbx55TNk0r424Nk2NYhpeIqOvRjOK7
         khFUJ+tawiQMYhzfEDTtWaiLipgzPnqosF/w6JQTIAwDcvrErg6dk7ptk800ummMyUxu
         RTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bsVlcHB3ec0VN84WfK2K0le9by2GbiEhUS8rbLlGQ7A=;
        b=IFTwVwXHKG46fiicSk6lARZJETNqyl7omRzNnlynJMAOLSANcVnlt1Eo0Tuxq9ZHWK
         qGBUghSAIJuuhHXOxThnfoGgk++lO2GGt9ZVocwkB6O2wAdMkO8L051gapOxsRxaveRB
         guJKZZwOj8JRr+H9CR85H+eaVauZXs5BRzKBr0pkiQm1Ur/sn0FEnSmWH2SBK+6rwzc1
         ph5YdgGN3mbf0UspIdo5lSa4+bUg0jpQKF9JhgsGcYCzFdV7bVlN6g2oQ/msOyZyPZd7
         tUGXrxSVd8FSKQ2tv2BnVxIfX2ZCWOHEWgkYnZ0fvOsGkqh55Hs7t8P2A5sFsN9ypHZD
         LQ1w==
X-Gm-Message-State: AOAM5327c4etQz9Y1q9e7G5U28ocDzgXWnUV45F0KCLJUQK7i61e3hT7
        t+gk5UIyIMEjIdS/va4yYss=
X-Google-Smtp-Source: ABdhPJxF82Jx8AWpmTbLkB9t++q6nHDTFIoZjRMGhxE012MeyYJxRtzWHabuaueTTW7d4dsX3vho7w==
X-Received: by 2002:adf:ea0d:0:b0:1f1:f958:a90c with SMTP id q13-20020adfea0d000000b001f1f958a90cmr13116245wrm.22.1647180221859;
        Sun, 13 Mar 2022 07:03:41 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm18388230wri.0.2022.03.13.07.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 07:03:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <05aecc5a-e8d2-b357-3bf1-3d0cb247c28d@redhat.com>
Date:   Sun, 13 Mar 2022 15:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v5 008/104] KVM: TDX: Add a function to initialize TDX
 module
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <b92217283fa96b85e9a683ca3fcf1b368cf8d1c4.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <b92217283fa96b85e9a683ca3fcf1b368cf8d1c4.1646422845.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 20:48, isaku.yamahata@intel.com wrote:
> +
> +	if (!tdx_module_initialized) {
> +		if (enable_tdx) {
> +			ret = __tdx_module_setup();
> +			if (ret)
> +				enable_tdx = false;

"enable_tdx = false" isn't great to do only when a VM is created.  Does 
it make sense to anticipate this to the point when the kvm_intel.ko 
module is loaded?

Paolo

> +			else
> +				tdx_module_initialized = true;
> +		} else
> +			ret = -EOPNOTSUPP;
> +	}
> +

