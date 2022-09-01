Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E50ECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 11:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiIALsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiIALsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:48:11 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB21616BB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:48:08 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so12183711otr.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gs2edPsujnl7CWNh7HlhsQUZIDEP93wl7jDr/MStIUw=;
        b=p4Jy2v4kA4G083K2jvV8paFTLopfZmvrFFiJVDXHA2CLiAiMQbvzaI+6xtM8fy/ioG
         q6v7h070g3jpHvc4zgWyn3PlpTVoAJgBTO2vVRqQ3EqVA8c08gieh25/eEkREYxnvqky
         TXkIBKV0x1PI2gdqV0XGCVMXGEeDH6C6muFw/yupvnl6MjMyjVVbFbPShk3Jp824gz71
         N7Rba0BKxgepKwaUOE+wXqFZ3V32Gshk2fFTQE/vAu0GyhiDDfyyUOytBQkvw7WZ40UR
         sh7VZ6I3eovXnP5i1aVdjY/A1mrIEVM/6RFgdxOsTWqH4+36C6UQ89MrljrPBnuhgQKp
         7dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gs2edPsujnl7CWNh7HlhsQUZIDEP93wl7jDr/MStIUw=;
        b=Nsotm8TWUqHdbRtPreYyrME5V2H089Os5koXia8axaVoltdEZpMhJP/+c3N7t255po
         LyDMsOKDATsnJ/+Lbt1c1Lpv4jjCy3pGS55xUb6N67/GKL7cOOSYKpDkS5p5Tv4yU86a
         Vycw3kN6Bw0gfc1U2eN0081iVEqyd9GwTN4v10FFvPMshsk62KH1D+EJUG3/PqoEbF3A
         21gVi1IWttE0OxiLbgcPOORDYYmmmZGg/ydVXKBSEb+I30lnQUfHAEg6pkUALbduYcWq
         fWTfQkbY7x7Z5t+zNOqasqT/yVEiKv8E2h6L6zQBA0FqwS3mqdX/vPqgQusWI2ieGsQc
         7MVg==
X-Gm-Message-State: ACgBeo0bcmJsr8lo/2H3Ig1YT26BitaqQb4BdmAKrTwXdfl0e2VjRTUm
        uxYMMSNj+8DBANkKnwwlbnR2B3RYFrDlS4/XyXYHOA==
X-Google-Smtp-Source: AA6agR6hJTVkzRjg9Zp0GaEGFRl4JLkQUdmzHa2xCc6eISLwJhjaURVIMa4Ntc6+O/EMeYoeT/5memUCEXVJ+lrAETU=
X-Received: by 2002:a05:6830:2a8e:b0:638:c41c:d5a1 with SMTP id
 s14-20020a0568302a8e00b00638c41cd5a1mr12801248otu.367.1662032887714; Thu, 01
 Sep 2022 04:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220831003506.4117148-1-seanjc@google.com> <20220831003506.4117148-4-seanjc@google.com>
 <17e776dccf01e03bce1356beb8db0741e2a13d9a.camel@redhat.com>
 <84c2e836d6ba4eae9fa20329bcbc1d19f8134b0f.camel@redhat.com>
 <Yw+MYLyVXvxmbIRY@google.com> <59206c01da236c836c58ff96c5b4123d18a28b2b.camel@redhat.com>
 <Yw+yjo4TMDYnyAt+@google.com> <c6e9a565d60fb602a9f4fc48f2ce635bf658f1ea.camel@redhat.com>
In-Reply-To: <c6e9a565d60fb602a9f4fc48f2ce635bf658f1ea.camel@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 1 Sep 2022 04:47:56 -0700
Message-ID: <CALMp9eQWHADOoQsocSWwwhyyxk-5oT=GzsGJSj1H=Lsfo=fuEQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] Revert "KVM: SVM: Introduce hybrid-AVIC mode"
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 3:26 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:

> I just know that nothing is absolute, in some rare cases (like different APIC base per cpu),
> it is just not feasable to support the spec.

Why isn't this feasible? We supported it when I was at VMware.
