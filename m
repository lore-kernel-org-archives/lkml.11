Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA5AC4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 22:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358263AbiDSWpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347902AbiDSWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:45:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B1E1E3EE;
        Tue, 19 Apr 2022 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650408181; x=1681944181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ezivpwo8e+MV8fNPdU02SOBEsQq4VFtgWGffC6YO01o=;
  b=wlxVGgFCzNByBECfHTrEMPwRxv0l1PmJNfXMhPz85F1PFewN4ptx7DXn
   N3d8LsxkTsNbKb/uc0UiYf4hcF9UnLQnXjGJtJfF558k6ckIh6ovhO1BZ
   RN2dFHh6c8BxqvQ9gwQgFePjFsY0SWqYxi1b1FEzHBjXIld0qEv60M7ft
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Apr 2022 15:43:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:43:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 15:43:00 -0700
Received: from hu-subbaram-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 15:43:00 -0700
From:   Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
To:     <vkoul@kernel.org>, <sboyd@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>, <david@ixit.cz>,
        <devicetree@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <~okias/devicetree@lists.sr.ht>
Subject: Re: [PATCH v3] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to yaml
Date:   Tue, 19 Apr 2022 15:42:55 -0700
Message-ID: <1650408175-12973-1-git-send-email-quic_subbaram@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YfjJOQIuGJvedFmJ@matsya>
References: <YfjJOQIuGJvedFmJ@matsya>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Convert Qualcomm PMIC SPMI binding to yaml format.

> Reviewed-by: Vinod Koul <vkoul@kernel.org>

> Steve, Can this be picked up please. I will rebase my v7 update based on
> this...

Can this DT bindings conversion patch be picked up please?

