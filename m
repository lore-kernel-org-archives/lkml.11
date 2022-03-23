Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369FFC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 12:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiCWM2i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCWM2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:28:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0D47B136;
        Wed, 23 Mar 2022 05:27:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648038424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDVMgslzXL3gRKImFxqbLng/cEJIgHfuf5NzQdxe1Rg=;
        b=M8SZiYDMlrcjHucSj/axq2y7HuL5uQmzl3JY2EFLvPwjY8o13wROJFJBpC3fcXFlr2jFp2
        j3F4QGSVe98OBOfO3bqZJsiAl2PPCihB0TSLQlXAg3PAq4Z7jqaKXHZMd9rq9VBwoECa83
        F6BTXPSJguIc+HZSA9cS7igyG3HmOJggwEuljr+ju8ZInv2/lw7Y19ymsy7g9aItKl5NUJ
        GqQEhOKFAUNDebiOGhbuyr/LSw1aImeQnAzIp5bxr1EBZgowqTgdMVyytA+/W7WADyjltV
        EkKMjg5XgRIrQJXURJAARw3JWlM3Yq4IS9G7yDOOkHXsXztZcniiulKsypqxtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648038424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDVMgslzXL3gRKImFxqbLng/cEJIgHfuf5NzQdxe1Rg=;
        b=UnGujgWRRnYP7tr5iZh/XI9r+CA+RRPnpEJExESxRzR8lYsUazcydY0eOCqTeMrkpW0S3j
        rAh0Vs8tx3I2UyAQ==
To:     Paolo Bonzini <bonzini@gnu.org>, dave.hansen@linux.intel.com
Cc:     yang.zhong@intel.com, ravi.v.shankar@intel.com, mingo@redhat.com,
        "Chang S. Bae" <chang.seok.bae@intel.com>, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        KVM list <kvm@vger.kernel.org>
Subject: Re: ping Re: [PATCH v4 0/2] x86: Fix ARCH_REQ_XCOMP_PERM and update
 the test
In-Reply-To: <a0bded7d-5bc0-12b9-2aca-c1c92d958293@gnu.org>
References: <20220129173647.27981-1-chang.seok.bae@intel.com>
 <a0bded7d-5bc0-12b9-2aca-c1c92d958293@gnu.org>
Date:   Wed, 23 Mar 2022 13:27:04 +0100
Message-ID: <87a6dgam7b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo,

On Wed, Mar 23 2022 at 12:04, Paolo Bonzini wrote:
> can this series be included in 5.18 and CCed to stable?

working on it. There is another issue with that which I'm currently
looking into.

Thanks,

        tglx
