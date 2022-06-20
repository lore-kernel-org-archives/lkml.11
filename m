Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4061CCA479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 19:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244693AbiFTTl5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbiFTTlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:41:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E447C1C903
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:41:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z7so16476342edm.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sEUI2YgJeyDPI47V6RGt0fYdsBueMJxQ+51x+bPWfXk=;
        b=t4uI+sFquTqOp8Ekf5vDFNUJIZQ2JiTt+PZKS4lhjldYnhigTwUmKYa/CLJJQGjipr
         cJtLZdqsy/zIP+EUpoU8fKSy61fQ+/X551Nep+Paroj8FB7c4obubL9X9I5qHI1SlEJp
         UIE6BPcW+tAPmwYMWGkqcMmAdQ2Spd5D44S4Pr4/wuc8TqzkmSwIYY+jlvFqpieMQlKM
         P6VCi60+oo1snCMBbYd8rlcwLqHgF6NP19BNyXhnI14Q18jKmx+QdlDu9oaW9U8YwC5s
         04lZHLFzIRzv6IGAEyjtY5rFKZC2ACP1id8364eECusOqKDMQDus2j/Lv9lXAVMGLyvf
         mVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEUI2YgJeyDPI47V6RGt0fYdsBueMJxQ+51x+bPWfXk=;
        b=UvSbv+WMJeXvwBIETy7l0czwahh2GDu0jbhDG7JdCYVuXVrapzHXdGHaMcEpbqthLw
         8UQKVidUG6MaaUj8cnYUrBsOJ6dBUbV2X7YO643P79IVWIdk+4oAdaA/wsBq2tQbQSoN
         Jvd6/uT6s+HBi8Ri4e292QLCjpxvz3uq82xEPh1JDqLjnSLrXlwTEZUOth+xGWvdaS8y
         py8uTKlomj6a53YJkmDfJkHljcIf6z2wEYHsY+00MfL+qWwYaPjfWUnkJPrjDDABwGXF
         oIOhXoYldON49dCklmvRNcbnNgP1OPrePC+F7fQnigDj85DAuLFAg+EOR7ckNcrJgqTk
         KnDg==
X-Gm-Message-State: AJIora/Sd2cKzZyy9+mgbCt57bQZJ35qoAoqZ8POIclUWthRPvV27atq
        CneVViGK6J+pGZU5zIIjZQpUPg==
X-Google-Smtp-Source: AGRyM1scAVu7vTSEgbiRLCuBIayZlj7HVQWoDuynLy+Uu1q2Kg8/F1hdn1mAdxVUHySH9O31TrhWkQ==
X-Received: by 2002:a50:fb9a:0:b0:435:6c0e:3342 with SMTP id e26-20020a50fb9a000000b004356c0e3342mr17380428edq.337.1655754109503;
        Mon, 20 Jun 2022 12:41:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o18-20020a056402439200b0042fbc23bfcesm11448549edc.46.2022.06.20.12.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 12:41:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, bjorn.andersson@linaro.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mgautam@codeaurora.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org
Subject: Re: (subset) [PATCH 01/13] dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
Date:   Mon, 20 Jun 2022 21:41:42 +0200
Message-Id: <165575403865.144830.4698856147792054347.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220504131923.214367-2-krzysztof.kozlowski@linaro.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org> <20220504131923.214367-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 15:19:11 +0200, Krzysztof Kozlowski wrote:
> Add compatible for qcom,sm8450-aoss-qmp with qcom,aoss-qmp as a
> fallback.  This fixes dtbs_check warnings like:
> 
>   sm8450-hdk.dtb: power-controller@c300000: compatible:0: 'qcom,sm8450-aoss-qmp' is not one of
>     ['qcom,sc7180-aoss-qmp', 'qcom,sc7280-aoss-qmp', 'qcom,sc8180x-aoss-qmp', 'qcom,sdm845-aoss-qmp',
>      'qcom,sm6350-aoss-qmp', 'qcom,sm8150-aoss-qmp', 'qcom,sm8250-aoss-qmp', 'qcom,sm8350-aoss-qmp']
> 
> [...]

Applied, thanks!

[01/13] dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
        https://git.kernel.org/krzk/linux-dt/c/cd3cd7d63543e4f963a0c823cd8fa29f4fe12f2a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
