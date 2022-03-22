Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E67C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 07:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbiCVHaN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbiCVHaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:30:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E5192AC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:28:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h23so23017736wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MDKAG7SMrCoXnVF+l0o9RQChI7eSiraXbGrVUFssuDg=;
        b=hNSrxWODF50pQO40YVypnZJsmYpBZpBUuv55+hnqeG5cDLaqzwvmwkam+ij5XTseS9
         gp7PiYlyN3Eq6XE9bZlukqLyqIrjy3xgen9sE8X1auwbQaosn82r2/e3f8Gx+hmbJcPB
         viidCktgYHMCdctwDFBW11nZvuv2cgENIiw5fqWApxfHFwivOz8/IkRIKT0muJ4VAVl9
         UPiwXowTGGqbDjbOT4DAy/kBt6RfOJUsEIP14kkvbUsyjvlCzXLNnEvtpoApVIsxsQvx
         Bj4gqaYt4cpIkR/yUUWrBGGQvJKcSWpr5eOwb3MG0z/0PtwLV5dsuGnCOckoXc3J/7E3
         3SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MDKAG7SMrCoXnVF+l0o9RQChI7eSiraXbGrVUFssuDg=;
        b=VxCQPPFcmT7rQj8Boeydo/3/YH/gFGfrAEBqSvuFoQn1vxmVqIQX8ffJrm4cr6X6V+
         xSDar1l6TdRzBWrKWkoLXQirzobaIN7EAzfci6xmZ/6vtoxEjB6W1krCLkLdju9xMHy7
         AweR82vp6NB4xc3blTzhrpyDZk8y6AkNofgKJgW7f3jItg5yxaZvLa6/NoHM8OJqd9Gn
         dBBl4G6lp1k4KLjfbe5+eakivzBK6Jnyj3BlicQu59QVhS7TCo5KXyHvHhYs2jB69A2n
         WDf6CQLzz27Zcwb20GMI9udAR5dUbvPZAzmJpdL4kOKOkAH2Nax6NimpWwguFL+DO2GJ
         E1rw==
X-Gm-Message-State: AOAM530OVzKnWW9xHBd0PZGuXVMkk7Po+CIit7xYvGV5cHPdSnaUTQnP
        ZeoQs1SYb8nstXkG+fRuHL2j6Q==
X-Google-Smtp-Source: ABdhPJzUp2T2xPe5zD2GNre1tdnUW1fy2x+Mc+OjA35iYioQAopDP3uM9EXZUo2jWKhrukA2daIbtg==
X-Received: by 2002:adf:f946:0:b0:1f0:62c3:ea2e with SMTP id q6-20020adff946000000b001f062c3ea2emr20438563wrr.348.1647934122705;
        Tue, 22 Mar 2022 00:28:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g10-20020adfe40a000000b00203eb3551f0sm17121425wrm.117.2022.03.22.00.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:28:42 -0700 (PDT)
Date:   Tue, 22 Mar 2022 07:28:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        kernel-janitors@vger.kernel.org, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/30] mfd: bd9576: fix typos in comments
Message-ID: <Yjl6qBPMEgjIN/Pk@google.com>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
 <20220314115354.144023-29-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220314115354.144023-29-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022, Julia Lawall wrote:

> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/mfd/rohm-bd9576.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
