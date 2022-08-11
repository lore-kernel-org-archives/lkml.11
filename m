Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7F4C00140
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 00:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiHKAQC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 20:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiHKAPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:15:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD8F65540
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:15:40 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x1-20020a056830278100b00636774b0e54so11705790otu.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc;
        bh=rH4tJJVaEKiEVSX/7gEAY/BKJ/vg9HsTOqIZEj5Pmh4=;
        b=h0aj7RgQ934e0ORmtu9pIYkIT6Z+gcdEaZXquy67TLMV6fKF1doh6+IH+Ih+3hFrDz
         TELVjZEBzRbJUq8tPbTEQA/LVyDrWQBexnyLeZg0MEVz2nP0yNhbckOc9pbQBxyEnWme
         aFHtmSlIXxlJYxB7QNAGnuAzmmCzDwd6wCrQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rH4tJJVaEKiEVSX/7gEAY/BKJ/vg9HsTOqIZEj5Pmh4=;
        b=JUJXebFrl4+TXW8CAkdXPKevfX3RtS9spMTrK+x63g8u+zI5YzrGJD58fGhEJOBwIn
         pwt+dWBDPoZAFs0QddWq4iD9Zs5t032u2hBuvA/d7wAnE0QelC8l9n9sJ+silv+9GNho
         Yr4NlOMgv9dnOhInAs7pRXiFIrGLlegEC5sRreRuhYrYo1qIgEAzgQMMFk5I51MEUeXp
         tkGQ1QIK9AyFsNuPtOGyX7wiYnuS2hdQ0ZXASHO4oTklBoJPAy5Ns/8A0xaoRO315n6s
         /sQTIXjPpvleragOqMvRbZxk7pRs1ifn2YnCutq4uxh1c0ogvPjIOvmn6poo5HMzpSB3
         IhFQ==
X-Gm-Message-State: ACgBeo37CWHGU3VPm6Mq2H9bh5+ZgJIJL0lDguNZSnpDBfDi3PVCEG/z
        IuItA/jky83al9IImz6X+q3ISc//8CuSX5x0O7+/tQ==
X-Google-Smtp-Source: AA6agR5BtDf4XxrUrg0Gk1lYiHMkGfXr1/IVnw2zv2k57Qwoaw08dnBtupoZEjg0MmKn5KxR5W5npRRcFJ+VX9QGae4=
X-Received: by 2002:a05:6830:2645:b0:61c:b7cd:bde3 with SMTP id
 f5-20020a056830264500b0061cb7cdbde3mr11142467otu.73.1660176940236; Wed, 10
 Aug 2022 17:15:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Aug 2022 19:15:39 -0500
MIME-Version: 1.0
In-Reply-To: <1660117558-21829-5-git-send-email-quic_srivasam@quicinc.com>
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com> <1660117558-21829-5-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 10 Aug 2022 19:15:39 -0500
Message-ID: <CAE-0n52=OzOG7qCXivVbsfJMdNCZJgJNSX3-3CeYqbW9tV3qqQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] remoteproc: qcom: Add compatible name for SC7280 ADSP
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-08-10 00:45:54)
> @@ -741,6 +757,7 @@ static const struct of_device_id adsp_of_match[] = {
>         { .compatible = "qcom,qcs404-cdsp-pil", .data = &cdsp_resource_init },
>         { .compatible = "qcom,sc7280-wpss-pil", .data = &wpss_resource_init },
>         { .compatible = "qcom,sdm845-adsp-pil", .data = &adsp_resource_init },
> +       { .compatible = "qcom,sc7280-adsp-pil", .data = &adsp_sc7280_resource_init },

Please keep this sorted on compatible string.
