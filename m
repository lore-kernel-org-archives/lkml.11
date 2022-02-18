Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5207C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 21:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbiBRVPQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:15:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiBRVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:15:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D78EA23D5D2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645218896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mdkq5WDrKOMtWJsUI9Y8r90L0uHveOCl6SsSn+lsYpA=;
        b=d7AXdyr39aABFNSHBwwt8wsH0h2cMdCEOXy5T7Eq0dpDmnXbfjrQYehJt5ydbYNj/NTWTG
        Q/VRrYJA/uQQeJ/c/gOczKkCTm4ydR1PCI6FcM/KuPcydZzMg4Q+FEZHxtYwXhmKZhTVMA
        eanCSVfyDNBzk2Wff7YNVLzC090Sop4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-wfz-AYKiP3CqK5JqRObjUA-1; Fri, 18 Feb 2022 16:14:55 -0500
X-MC-Unique: wfz-AYKiP3CqK5JqRObjUA-1
Received: by mail-ot1-f72.google.com with SMTP id h7-20020a9d5547000000b005ad0f5e4271so2055181oti.19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mdkq5WDrKOMtWJsUI9Y8r90L0uHveOCl6SsSn+lsYpA=;
        b=sCFKRNB3mSyBwsg/SBE+6wdMnG9JaykvdWhTDKCz1RE/15eUYq4keIH0ePKLifyRen
         JvW+r/lfLBoCvu/75ClkPTxNddZ4frA6NaX3aHW1AUPTSxH9cfcoLly5dCIsqHyWhRV3
         EPq8lqbdibu8K9tNpHd6xZtNLS5sXw8N/IaJy+2RpyiBRKgfPYlEThmW394y2GDD7dd2
         vfbVHkhTFayGcw1VAPLUW/L/JDSa4SvyUumMkGuXEXRCTqgkm4WDO/NxYOKseSE7NF8K
         Z0b+geBajTcbbeOUrzGBBtQmDJeA7tD1zmBcpdxHQxGSiNKrr6NBO1G51I4CRndlCGx/
         +KfQ==
X-Gm-Message-State: AOAM530GMpVHGuEowOb+m2MKtIgd0/XBeJSpnJeNIPPsFxvxpbvviW96
        M3xZ0rpm/7hAhdKnLq/FyPz9Ac8w+8I4n+Kc2Jlne9HouCqhFMDpFtnboIKxvujqwjuSxkhzJAb
        0FEl81ZN5STSR2Gw7cQLTiCuH
X-Received: by 2002:a05:6808:180e:b0:2d4:72da:ad57 with SMTP id bh14-20020a056808180e00b002d472daad57mr4051616oib.252.1645218894418;
        Fri, 18 Feb 2022 13:14:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzE1Oac1nGTb06HI35UZWwctsmQuX0LvWzJW8SDI7kCT5BKsBrJbnCZTg3uXVv+8zlRYsDZBg==
X-Received: by 2002:a05:6808:180e:b0:2d4:72da:ad57 with SMTP id bh14-20020a056808180e00b002d472daad57mr4051609oib.252.1645218894261;
        Fri, 18 Feb 2022 13:14:54 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id l14sm1854029ooq.12.2022.02.18.13.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:14:53 -0800 (PST)
Date:   Fri, 18 Feb 2022 13:14:51 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 05/29] x86: Base IBT bits
Message-ID: <20220218211451.6h6gdlbnnuxhhati@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.867389898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171408.867389898@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:07PM +0100, Peter Zijlstra wrote:
> +#ifdef CONFIG_X86_64
> +#define ASM_ENDBR	"endbr64\n\t"
> +#else
> +#define ASM_ENDBR	"endbr32\n\t"
> +#endif

Is it safe to assume all supported assemblers know this instruction?

-- 
Josh

