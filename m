Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF76C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 23:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiGRXAJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 19:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbiGRW7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:50 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC5532ED9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:29 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso4359942otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9uvGSzroWjoVfHZJxd/jP0wL1QmlvUg5yn72pwqI0I=;
        b=VdTBptN4eO2NpeqqPoe5GdkpMEUlXFCQpwdSdAOSpVvmXNdG0KCClNMyGdrrdDxMGD
         afhn+751jbTmz0g0/nW7VmrSCFYYtBRMw21QAojyVzSO1tY5yRT2B7G6uDA0MfFZmG7I
         hi8f3Rf1u66kY7SdY4zBPZPAOcZEkhUAuEHHUMUMEP5EsSDt44XUQxAktxyHXZD88UHw
         yhfRNzuR+xHgV+GBTzpPfUkzB09YTho5Z+L+baYnQwCbxLfO+fX33xKEkgmHsAbnFBZC
         CP9sZKbjzavpKSLasz4mUAwrPRQJMARGh1irl65JMgVpanxGnPJP4cSBIO8RcEUyHUdV
         JgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9uvGSzroWjoVfHZJxd/jP0wL1QmlvUg5yn72pwqI0I=;
        b=l+PS008KWJTzJC3xvMLb1uzMVVpgQuoe3eBeFNaUCMgSYG4bk5L3g7/sqZ9WpyM3mV
         M/e49d00D3R8soJ+6pCChlm6QYB7KATIaKAGpgPpiPxG0HloNnJ9QNPV4T4jbFR9nOvV
         RA21MNVmTeplpC6F0YZLViKbjHA8pyztY6Rl00Qzsgqn4tHJbhAYdTDJvZgdAIUm7PSD
         /bDXGUqfCUNoNUmyWUoY/tpL9qZodoeXRLT3PQUzwZcqfN2wXwc1ogEksOA1rxdXosab
         VU6lZL/PDjrP72wZ2EEodTFZLWCuk3/fZTYdhdyJWRaa2QeI6c/381p7WUkrk4xc6aTQ
         PI/Q==
X-Gm-Message-State: AJIora9ty9NBs+wQAIKyYSd8X9hK2rGkOElAY6mh5zB2Bl6jSdlSK1+k
        kKhPFmeGcbeMmF4KcNHjk10D4un9qhTl6w==
X-Google-Smtp-Source: AGRyM1scRd6qfItxMF0kVTiLUflrmntQdMj7Ohkld0t9MpwdXNUaxUWMur5cDR5XJnnCDhJtdGJ+ag==
X-Received: by 2002:a9d:162:0:b0:61c:af45:b49 with SMTP id 89-20020a9d0162000000b0061caf450b49mr1276100otu.34.1658185169444;
        Mon, 18 Jul 2022 15:59:29 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     quic_sibis@quicinc.com
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [V4 0/2] Add modem debug features
Date:   Mon, 18 Jul 2022 17:59:14 -0500
Message-Id: <165817634386.1905814.11533652589049191343.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1653396335-6295-1-git-send-email-quic_sibis@quicinc.com>
References: <1653396335-6295-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 18:15:33 +0530, Sibi Sankar wrote:
> The series adds support for the following modem debug features:
>  * Pass on MBA log info to imem
>  * Add panic handler for mss
> 
> V4:
>  * Restart the update mba info to imem patch that was dropped from V2
>  * Add panic handler for mss driver
>  * Drop patches that have already landed
> 
> [...]

Applied, thanks!

[1/2] remoteproc: qcom_q6v5_mss: Update MBA log info
      commit: 347c51ba5e49e35c5f4ee78f8664f08429b52b6d
[2/2] remoteproc: qcom_q6v5: Introduce panic handler for MSS
      commit: 3b1d265a846292464f6716b8c3a546252f73a7d7

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
