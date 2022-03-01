Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EBCC4332F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 01:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiCAByi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 20:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiCAByf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:54:35 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5247F0C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:53:54 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so20939181oob.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SH7BKZxPThE9TeccoqRlmHSDAbpqji1kQcAbZPM4yik=;
        b=ge1Da0sWeE+tqpMjsT64kOiWt8LAtWVXCsDWyFEpfMIYtGC3XmXur327uUyvKTqcJ9
         pHSrCqJvbjI+J87pCRkOcUkWnZ6iv9y2s/dhTuqDW5KvoH0bFC5bTyW3KbzdBmyLWUg9
         Toqim7tenpe3VhvO7sQRhxdXhduSoPWy2pCCR/xMAhUpGk08CsxgJkQhqq26fDMqbi4D
         3t5Di6QRwd7b7R7ZcupOgGLqy/wfO49OAA9gp76WYJiQMls+cF9nlfDf6QbNcklF4QbM
         4nUOsCOpcqBOp4CVSPFPc56vQPLjZ0GuPLuP6l2BHlNKtoGOE+VxSKO+r44Eduf+ET/W
         j1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SH7BKZxPThE9TeccoqRlmHSDAbpqji1kQcAbZPM4yik=;
        b=tB7ug/Du3n3fEN3+639uzzgtzvu2SDpCA1kgE5qGFGdFMnM9qAxVUWhCS2hECaPqxl
         kPJHse33+TYiYmpUg+V8dWprc2XsycMkgVwUR+YBOkzXeWDgB/Vjjh7ADf/uTLoHIag4
         DXWKVtBRD698dzVxOHjtFEjkMgtamwEl36uAEo9XHNMwPmuF9ViM9yR2NjnkmzNIQ8Y9
         JIc96Ee7m27NAp5nsgRyVhBJ72S0wYXVHydCCszRRasnzlaYBOTsenQiUrQdAaLnQktc
         s/YowPmWApLApe04KiPB1jSwJZTwc2GQ149TtQ9HOIrPO2Z4TZvTK5n4eLFcpz25Q2hd
         RD1A==
X-Gm-Message-State: AOAM531sWe8cvy/n3nkHMxn6jw3Mop5UPYAbYwa9c7tz4VeT4HQalP+g
        Y4+TLZNwLti5uzV9ywM5q4UJLdw9F4VJHQ==
X-Google-Smtp-Source: ABdhPJwkZfZQgsIvBnKi4vwbk0wX9q6loJUIaLI+i80+obbQoS3tfkqdkthJvfyCPGd6372X23Sm7g==
X-Received: by 2002:a05:6870:e997:b0:ce:c0c9:61d with SMTP id r23-20020a056870e99700b000cec0c9061dmr10096537oao.111.1646099634137;
        Mon, 28 Feb 2022 17:53:54 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id 35-20020a9d0026000000b005ad363440a2sm5669549ota.64.2022.02.28.17.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:53:53 -0800 (PST)
Date:   Mon, 28 Feb 2022 19:53:51 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     lotte bai <baihaowen88@gmail.com>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qmi: Use min() instead of doing it manually
Message-ID: <Yh18r0jpHjswyksi@yoga>
References: <CAFo17PjBtoWcrQyxe-Twowf+_5FJ3_OOMjtv950VBR7NocWfhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFo17PjBtoWcrQyxe-Twowf+_5FJ3_OOMjtv950VBR7NocWfhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Feb 19:36 CST 2022, lotte bai wrote:

> Fix following coccicheck warning:
> drivers/soc/qcom/qmi_interface.c:773:12-13: WARNING opportunity for min()
> 

Thanks for the patch Haowen.

> Signed-off-by: Haowen Bai <baihaowen88@gmail.com>
> ---
>  drivers/soc/qcom/qmi_interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qmi_interface.c
> b/drivers/soc/qcom/qmi_interface.c
> index c8c4c73..3337a70 100644
> --- a/drivers/soc/qcom/qmi_interface.c
> +++ b/drivers/soc/qcom/qmi_interface.c
> @@ -770,7 +770,7 @@ static ssize_t qmi_send_message(struct qmi_handle *qmi,
> 
>          kfree(msg);
> 
> -       return ret < 0 ? ret : 0;
> +       return min(ret, 0);

The code isn't trying to say "return the minimum of ret and 0", it says
"if ret is negative return that, otherwise return 0".

Mathematically this happens to be the same, but for me as reader of the
code they have different meaning.

Regards,
Bjorn
