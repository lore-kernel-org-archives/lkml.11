Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5CAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 11:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiERLqW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiERLqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:46:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBCBF6D;
        Wed, 18 May 2022 04:45:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g12so2645647edq.4;
        Wed, 18 May 2022 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKmftTACwKl85v+K7ODpphTsqLyA4iR1rRxXpV4eOs8=;
        b=OTSJdAYA1KWzJgDZibIIZi44eBvyBBU+GntJp9Kn9Mo9tJQL2SfuwRTyiv1i+cd5rK
         VwNusikmeqNOAi0eo75fc19WaBXjuWE7C6ZYoM0jOTR9XIAF15mFZCCwRDXHTM7WJmip
         VVa1DifM/bSXJbeNIO8yZPJ0XuKAKSfnfA+dIQmhCgwoeH+t7Qq74my4EWPEETnhgHee
         qAR9PC1AzCvWBXNUaQJsOnjN6E2ab98GlgfTjGwFfTFMZ46DLkDUCp3JBmzIrA+9mmQt
         B8gcY3dQKxraHEvV8IWnTLA6zacZvT6UdNtNBTefFLSTDVZeB6CICLFlK286JumzAr4w
         akeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKmftTACwKl85v+K7ODpphTsqLyA4iR1rRxXpV4eOs8=;
        b=t7UVWZuohSElUzssJz7YWY3Bs4GDWCUKYw8CVcOsZxdTMEHQqmSiO6QXdLRDeo20yu
         uh6plrJFJcxqyiHcEKHPqvC6yUJz37ON/ZX95BDufUWdiS4hsttlJIx0AV4WBMNcw2c4
         gWqTvOtlV87+Y8PLGyLn1Oe0oC8adCOm+O6hDMBtr8j0S/PQyLLvNeF1+KsPsz9P+uhy
         xzO7oNuDrOGdQO+XJXiFC1BkxKJNkJYhfL+03jqkrhljN/0DXpt2ORcySJqg+4nu+RHj
         ikuDZkopkL2pAkmVNWtg19INOmn0THi8tlWGdw+pOloiEUO5ZnZlB+4INpfRrcuh5+f8
         C43Q==
X-Gm-Message-State: AOAM530rYUNqTY9zh7dSei7RpdCHaM3vIFLsUHyiHBdb0qWV9Fgg7DeJ
        h4gkZYJx0xuXEMcELdrqr18=
X-Google-Smtp-Source: ABdhPJxtHHqAaTTw9fc9OqZBLQtF7b+D+6qCrGLXMnMRiG6X8TMHrG84h4r6VCDiEXYAY7K99pOK6w==
X-Received: by 2002:a05:6402:90e:b0:425:a4bc:db86 with SMTP id g14-20020a056402090e00b00425a4bcdb86mr23675838edz.98.1652874357203;
        Wed, 18 May 2022 04:45:57 -0700 (PDT)
Received: from skbuf ([188.25.255.186])
        by smtp.gmail.com with ESMTPSA id f9-20020a170906738900b006fe8ec44461sm366774ejl.101.2022.05.18.04.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 04:45:56 -0700 (PDT)
Date:   Wed, 18 May 2022 14:45:55 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH net v1 1/2] net: dsa: lantiq_gswip: Fix start index in
 gswip_port_fdb()
Message-ID: <20220518114555.piutpdmdzvst2cvu@skbuf>
References: <20220517194015.1081632-1-martin.blumenstingl@googlemail.com>
 <20220517194015.1081632-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517194015.1081632-2-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, May 17, 2022 at 09:40:14PM +0200, Martin Blumenstingl wrote:
> The first N entries in priv->vlans are reserved for managing ports which
> are not part of a bridge. Use priv->hw_info->max_ports to consistently
> access per-bridge entries at index 7. Starting at
> priv->hw_info->cpu_port (6) is harmless in this case because
> priv->vlan[6].bridge is always NULL so the comparison result is always
> false (which results in this entry being skipped).
> 
> Fixes: 58c59ef9e930c4 ("net: dsa: lantiq: Add Forwarding Database access")
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

The patch, as well as other improvements you might want to bring to the gswip driver
(we have more streamlined support in DSA now for FDB isolation, see ds->fdb_isolation)
is appreciated.

But I don't think that a code cleanup patch that makes no functional
difference, and isn't otherwise needed by other backported patches,
should be sent to the "net" tree, and be backported to "stable" later?
