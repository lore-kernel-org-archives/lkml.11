Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C26ECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 21:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiH3VmV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiH3VmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:42:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E562525590
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:42:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so13158419pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3XqpzaqQIPLLyGi5qlAgQvhm1XAd7i62on0gjzVN0C0=;
        b=ar6AR/LJiMEdz55YDLufQJ3SK+VbOZr+1+ygsp7jTCPgahrZtANpZGSAWrK0j8oW2O
         HPW8Ptl5kt1nH68P0ZJqaETs5MU95uYWBJhnR6feye0basU1oqcjeGccAW4cuamX7Vbc
         hOnKZDpaJPurhUdok02WSfXdMqeQ9nKyeaFQuH1B0pjPw+5fllW/yYFRVmWNJNYttpUH
         /CcBeXKcrp6Ol09QNnUGgk8Du5bFnbl1su9uL5gskz3A6YhEECrAh43HruBf8sfbSp8V
         5BnKj1iJD/+bxSrHd6jeBDrO27OBBuOoBGfBcu9jRouHWQqcdMWb0WaPveNuAVG0Bift
         ZI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3XqpzaqQIPLLyGi5qlAgQvhm1XAd7i62on0gjzVN0C0=;
        b=4xcdt4hrAypsD/erMQZ3yzkU7Q6n1iobzXKKbFwXo4Cvd5CqGhzHiR+eGMQck/AWOx
         EmUgqZGsqGKcKrTUuaXqTHBzS3MMZymUdSFvVdL73/yMBlW8J+Nv5fSyWlwYD3P8udRF
         hisVcUDx4T88Re91tuxP3mPivtKni5cNIfXLH/PyOUtqMeV2cRo6EgKUfvTpGpCt3bEi
         t/HntPMz2Rhxoq/jJ1US7zNx0mY5PW3pC4D+N20m+NX2GzfqAcX8SnOU5lsr/yNt1cBx
         WmOv4qfHViQe67mW6iEWumDat5tpKfpvm+W9LUkGoDLHERHvKbg/vW1O8vTL4p9ephGD
         4NMA==
X-Gm-Message-State: ACgBeo26TKmb4n2cLmzjvuYvf7cramqnWInpMd3nX2LhUo1tE9nnQ6vc
        U9bVlwDStcs6jeCrw8nRIn1EdA==
X-Google-Smtp-Source: AA6agR4vORPDKq/5w5NFBDKnl2wG/K63gRfZITOVeW2rgAZxnZ3bxwSzqUcDyBR92DYtTI4LoE3phQ==
X-Received: by 2002:a17:90b:46c2:b0:1fd:7fe4:2217 with SMTP id jx2-20020a17090b46c200b001fd7fe42217mr43488pjb.146.1661895735212;
        Tue, 30 Aug 2022 14:42:15 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d144-20020a621d96000000b00537a6c78ef1sm9776401pfd.190.2022.08.30.14.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:42:14 -0700 (PDT)
Date:   Tue, 30 Aug 2022 21:42:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Add extra information in kvm_page_fault trace point
Message-ID: <Yw6EMoRhtdoyX9Ve@google.com>
References: <20220510071001.87169-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510071001.87169-1-vvghjk1234@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022, Wonhyuk Yang wrote:
> Currently, kvm_page_fault trace point provide fault_address and error
> code. However it is not enough to find which cpu and instruction
> cause kvm_page_faults. So add vcpu id and instruction pointer in
> kvm_page_fault trace point.
> 
> Cc: Baik Song An <bsahn@etri.re.kr>
> Cc: Hong Yeon Kim <kimhy@etri.re.kr>
> Cc: Taeung Song <taeung@reallinux.co.kr>
> Cc: linuxgeek@linuxgeek.io
> Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> ---

Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way to kvm/queue "soon".

Note, the commit IDs are not guaranteed to be stable.
