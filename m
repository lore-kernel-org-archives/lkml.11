Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAA4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 18:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiCAS6r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiCAS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:58:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FF613E1D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646161076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79qgkMv7Kg2QVk5mvxLZjjniRJCyI9kiBcfGLVd0aO0=;
        b=S3uLf/xbbVuDzFOrUMPgFIzZQNGQeenuanFxgKwHD/csaxUybA2jraJDGPDO0AJcVYUr/G
        9w8zIuknhP4ZgM2rlzznHzYK34cW8lu6Z30Fr6Y7UfxQfyhexs4brlTtDwxyv/SB6S5M7o
        oKgtbcJHATBdDhGUA52oWegGc8gVF9Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-GpPt4QaeMnCGLGoGpPSQLg-1; Tue, 01 Mar 2022 13:57:55 -0500
X-MC-Unique: GpPt4QaeMnCGLGoGpPSQLg-1
Received: by mail-ej1-f71.google.com with SMTP id hc39-20020a17090716a700b006ce88cf89dfso7280665ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 10:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=79qgkMv7Kg2QVk5mvxLZjjniRJCyI9kiBcfGLVd0aO0=;
        b=V3t8D3uzAQtMkPHW0laWRF3p244PqySTrf9CTkTujlD0Nqy50pkjsl2ie2ibbL9z6R
         Niu1R76LMZNHE+RpBYasJ+vHyR16nLfIFdF1AJYC1EEkkZ0TAC0Vd1//qFYSnFYv6A9g
         HDZjLh8jnHElf7XaOvcX3WFGutJRTw3TOx2TAUpvrUxNy+rySn7CDCFZP4T/UpbMZnt0
         MHzzSUSvSH8vJwT6MEpD99zqsjkjsYjA8guMyir1d8/tkRe5Aba5Kdr+eMF7tgcbnpgr
         NdrJEwCcCD81h5oMY/R+lkj1ck/P5Xr57fzdf/A15AM624+Gwc8ryZoqRnndrelUMLLb
         M8kw==
X-Gm-Message-State: AOAM533o38iynmEMsH4CGIiHuFlSD2e7q3C56BtgEb2PV966/yVi4uFJ
        cURbzsapKGS0XoLEFuNJdEq2sToF70kP9Lhas1BFV85hasteRRFAwYLELQtrPyUetkMnDf/IS55
        XrMb+ng9WJmLezTfNaGL7VlIF
X-Received: by 2002:a17:906:9454:b0:6b5:aa6:2822 with SMTP id z20-20020a170906945400b006b50aa62822mr19421330ejx.619.1646161074689;
        Tue, 01 Mar 2022 10:57:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWyQJGdfJSwtieHxHfMmV5Fdq1QhqNCjIDL8D1LNthyaaEXz6MBcCe3dgkVAKYywMa57cnzA==
X-Received: by 2002:a17:906:9454:b0:6b5:aa6:2822 with SMTP id z20-20020a170906945400b006b50aa62822mr19421324ejx.619.1646161074503;
        Tue, 01 Mar 2022 10:57:54 -0800 (PST)
Received: from [10.0.0.45] (host-95-232-30-176.retail.telecomitalia.it. [95.232.30.176])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7ce0a000000b00412eb8dcbd2sm7571746edv.9.2022.03.01.10.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 10:57:54 -0800 (PST)
Message-ID: <60c62d7a-940a-e424-15e0-af47cd36eacf@redhat.com>
Date:   Tue, 1 Mar 2022 19:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] sched/isolation: use raw_smp_processor_id() in
 housekeeping_any_cpu()
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, frederic@kernel.org, rostedt@goodmis.org
Cc:     tglx@linutronix.de, mtosatti@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220301113053.141514-1-nsaenzju@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220301113053.141514-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 12:30, Nicolas Saenz Julienne wrote:
> housekeeping_any_cpu() will return a housekeeping CPU. That's it. It'll
> try to optimize for NUMA locality and to use the local CPU, but it's not
> a requisite.
> 
> So let's use raw_smp_processor_id() instead of its vanilla counterpart
> in order to allow users to query for housekeeping CPUs without having to
> disable preemption.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

