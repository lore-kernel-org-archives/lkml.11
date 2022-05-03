Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 11:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiECLyJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiECLyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:54:06 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3F113F38;
        Tue,  3 May 2022 04:50:33 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id a5so12007854qvx.1;
        Tue, 03 May 2022 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AfK5VzV7OY5z7mYDkfdtwnn2sckKW7LiSOvSIKrhTZ4=;
        b=io4AOsON+rOChSAehjoG9IDcfqNiSYJP2iWTgI0DjWN8Y6auP6a0dkkw3gTs9XBU80
         KTCBBtRru9nWuCuXO6oK3KgZu4lXO4HpQbf0R+Vhh477UHn2gTXTbAFcZVO3d0zGKzCB
         ItN9Y6cr2gzzAwlGq/bCjm+SinKJsDavp3RbIxWYS/29kHePEungTcqisKiFztv42s4j
         WS/9/tnp2lQP4aPed8VAWdxA8ONAVd0BI3hM0yU3kJeoo0Ee4V5JzhxBO4zbTL0odL1r
         gwtKemP5IMWFFlrhC4Yio25GIFvcN80EoKimrRv2byrNf0T5HIW4RO1XuJGnZ4uhsLT/
         JADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AfK5VzV7OY5z7mYDkfdtwnn2sckKW7LiSOvSIKrhTZ4=;
        b=JUwhTp3DwA4+sN6W2cDQNxbM4sc21mwFNc7y98MQWd7ql1eypGBJU9ABs30lPc4yks
         mN3gzMp9x6gaF8n7pzL+TFTx9GGRcXBKg/6oWQ7G1l0vkz4iB1BhIKPgrGZe8R+heWZB
         lzyZnoilOOY2z0WjNHeo/k1rBFg+B7tPjPPeNbPB458tE05w2qmRgSzAbHkPFCWFgeWo
         3PypdtDI+jL8jnSTFNrfumVad+L6y8Mwkj+IWpQg7dJcZQhPzRsdTR/BYHTo1GwqJ6oS
         IcA6yL0yVsZJYWuD8FttYoIwkGJZRBKouV/KOGue0vWvQAoizb4RAHaFFYxt2XD8k9QC
         riHA==
X-Gm-Message-State: AOAM533/ILz1yzKHvpFNXZeNXbK0kv5TOYQHSCPmdDY1c+4ZtfSuLbMS
        OS59OMpmVGQekr3V/Gfgu0U=
X-Google-Smtp-Source: ABdhPJzWivOeozTqw5kESds912tx4dcrY+V8jwp517uxq6uTtalAOu73hdaRAvY1GCE0YnsGCYzI1Q==
X-Received: by 2002:a05:6214:1bcd:b0:456:4103:7209 with SMTP id m13-20020a0562141bcd00b0045641037209mr12816767qvc.45.1651578632651;
        Tue, 03 May 2022 04:50:32 -0700 (PDT)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id h23-20020ac85497000000b002f39b99f6b9sm5694009qtq.83.2022.05.03.04.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 04:50:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <9085a08b-cbf8-8c79-f75d-61ae03bd92c5@redhat.com>
Date:   Tue, 3 May 2022 13:50:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86/svm: Account for family 17h event renumberings
 in amd_pmc_perf_hw_id
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     Kyle Huey <me@kylehuey.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Like Xu <like.xu.linux@gmail.com>
References: <20220503050136.86298-1-khuey@kylehuey.com>
 <20220503094631.1070921-1-pbonzini@redhat.com>
 <CALMp9eTCY3tMGL4=g4UfxGJoVhVB6KGu+vbwL-aDr+HJyaBBcQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eTCY3tMGL4=g4UfxGJoVhVB6KGu+vbwL-aDr+HJyaBBcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 12:00, Jim Mattson wrote:
>> Queued, thanks.
> Isn't it better to just drop this entirely, as in
> https://lore.kernel.org/kvm/20220411093537.11558-12-likexu@tencent.com/?

I plan to do that on top, this patch is good enough for stable.

Paolo
