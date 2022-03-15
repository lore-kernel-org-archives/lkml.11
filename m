Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93CBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 12:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbiCOMXE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348225AbiCOMXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C826852B05
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647346907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXboPqU1D0WQ3MWcUTFOVkR/M0ow9vS7S0ofpF7HN+U=;
        b=TfBs6GeYMowVe85X9H8LXQ2NQSPQFxJeMNIqL8til1w12MNijUHZeH4wRsvxkn/0oIihcA
        31jqL1Oh66M7PTE2cwOYxssk2ymEoSRfnXus8NVcasgS3rx3/1z9B+IMbE3wQUi9yrNNNE
        WYgqmvj9O+c0aUOWOHrXznpAs9mS0cA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-65-ms_gAPJqQqa2udcNlUg-1; Tue, 15 Mar 2022 08:21:42 -0400
X-MC-Unique: 65-ms_gAPJqQqa2udcNlUg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9FDA833961;
        Tue, 15 Mar 2022 12:21:41 +0000 (UTC)
Received: from localhost (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32F18426322;
        Tue, 15 Mar 2022 12:21:40 +0000 (UTC)
Date:   Tue, 15 Mar 2022 20:21:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v21 1/5] kdump: return -ENOENT if required cmdline option
 does not exist
Message-ID: <YjCE0Scp2YiEJXBM@MiWiFi-R3L-srv>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-2-thunder.leizhen@huawei.com>
 <YjB/QILintgvo1AL@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjB/QILintgvo1AL@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/22 at 07:57pm, Baoquan He wrote:
> On 02/27/22 at 11:07am, Zhen Lei wrote:
> > The crashkernel=Y,low is an optional command-line option. When it doesn't
> > exist, kernel will try to allocate minimum required memory below 4G
> > automatically. Give it a unique error code to distinguish it from other
> > error scenarios.
> > 
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > ---
> >  kernel/crash_core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 256cf6db573cd09..4d57c03714f4e13 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -243,9 +243,8 @@ static int __init __parse_crashkernel(char *cmdline,
> >  	*crash_base = 0;
> >  
> >  	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
> > -
> >  	if (!ck_cmdline)
> > -		return -EINVAL;
> > +		return -ENOENT;
> 
> Firstly, I am not sure if '-ENOENT' is a right value to return. From the
> code comment of ENOENT, it's used for file or dir?
> #define ENOENT           2      /* No such file or directory */
> 
> Secondly, we ever discussed the case including
>  - no crashkernel=,low is provided;
>  - messy code is provied, e.g crashkernel=aaaaaabbbb,low

Checking the 3rd pach, this is handled. Take back my below words,
continue reviewing.

> 
> The 2nd one is not handled in this patchset. How about taking the
> handling into another round of patches. This patchset just adds
> crashkernel=,high purely.
> 
> >  
> >  	ck_cmdline += strlen(name);
> >  
> > -- 
> > 2.25.1
> > 
> 

