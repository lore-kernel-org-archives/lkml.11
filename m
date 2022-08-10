Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E611C25B06
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 12:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiHJMxG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiHJMww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60000AE21C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660135961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uU8Ji2H2jJkrFfWn1VZHBL0MhVKEFsbTbqMVDnVch7k=;
        b=XXCg5ivvbRgiaiM0U01od4CfYw5gV8MwF3io5xgf8fLJhmWroh9y//uDSEPla9X+SFZRPW
        tu2wWEtsTKnY4Hg1wi50FFaN+ZT1CZ0/LpdGmEnAhFo3M+zG1Bf/Bj1nUYMgV9rwpritPq
        /p010n5DSkM3Nwb9LCd1RG6kDO/NpI0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-iEPcwJjdPXWdIQTj-MB9aA-1; Wed, 10 Aug 2022 08:52:40 -0400
X-MC-Unique: iEPcwJjdPXWdIQTj-MB9aA-1
Received: by mail-ej1-f71.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso4139125ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uU8Ji2H2jJkrFfWn1VZHBL0MhVKEFsbTbqMVDnVch7k=;
        b=DOkX9xXiKRG/wL0+eMWnyK5ErFqkbqngJIe52YPaFJtQ/M2LEwVFXpXhMAVesJnmTB
         V5s3YZ1lV3VsaW3EpeNnN1r6E9TF4Ta86kZd4YtIZP4vMDGtRYepemiQ66wi5yvsSzKg
         3cPt+RPRZhT4ZwtpW2sHXu8IkRpuObzgN7paW0GsWV07WtmyNHtTO4ObLfeoPt+Uo8xP
         6HdQpsn7nRCLo2UHXlun9/fd9n52Y/HUAF50mtxXbbu96ggkC44GGyc++MxQLfEoyFy3
         fO3RT8jPcpCKcDbN9779MSChABkeg13LtiL5Ba6N9YvocozihTIRzVenOVS0sdz+6T60
         bhIQ==
X-Gm-Message-State: ACgBeo2eimScMTksllcmbDQ6YFiPX7a/DYO71hgoS8szNaLW/ZJWPpbR
        2dvW4KAaX/FfR6c1tiTsnHUtwpOAuQ+jpGTuwPkyEHd8LLJbRGxhm9rlyJVAq/BQ3PMuNhcTLwA
        6nDrBHLk91TPuyUr5mz//iTxY
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr20613730ejc.81.1660135958969;
        Wed, 10 Aug 2022 05:52:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6XzpJkuBwStNL5JtL1fuUuqeVnj1aaChdrmp243FOLsAudH26ztnYFMlhCIjB28Hk+1xAj7g==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr20613723ejc.81.1660135958787;
        Wed, 10 Aug 2022 05:52:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id y10-20020a50eb8a000000b0043ccd4d15eesm7559461edr.64.2022.08.10.05.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:52:38 -0700 (PDT)
Message-ID: <c2335a69-c243-3c5f-b983-938c91cb5c2c@redhat.com>
Date:   Wed, 10 Aug 2022 14:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 0/3] KVM: x86: Disallow writes to feature MSRs
 post-KVM_RUN
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
References: <20220805172945.35412-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220805172945.35412-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 19:29, Sean Christopherson wrote:
> Give feature MSRs that same treatment as CPUID and disallow changing said
> MSRs after KVM_RUN.
> 
> RFC as this is lightly tested and should come with a selftests update to
> verify it actually works.  Posting early to get feedback on the overall
> idea, and on the VMX MSRs trickery (though I think patches 1-2 are a good
> idea irrespective of trying to reduce the overhead of the new check).

They are good, just a small style remark on patch 2.

Paolo

